package nl.tue.vmcourse.toy.bci;

import nl.tue.vmcourse.toy.bci.value.*;
import nl.tue.vmcourse.toy.interpreter.ToyAbstractFunctionBody;
import nl.tue.vmcourse.toy.interpreter.ToySyntaxErrorException;
import nl.tue.vmcourse.toy.lang.RootCallTarget;
import nl.tue.vmcourse.toy.lang.VirtualFrame;
import nl.tue.vmcourse.toy.jit.JITCompiler;

import java.math.BigInteger;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ToyBciLoop extends ToyAbstractFunctionBody {

    private static final int JIT_COMPILATION_THRESHOLD = 3;
    public static final boolean INLINE_CACHING = System.getProperty("toy.InlineCaches") != null;
    private static final int LOCALS_SLOTS = 256;
    private static final Map<Class<?>, ConstantBoxer> BOXER = new HashMap<>();
//    private static final Map<Class<? extends Value>, ConstantUnboxer<? extends Value>> UNBOXER = new HashMap<>();

    private static void checkAddr(int target, int codeLen) {
        if (target < 0 || target > codeLen) {
            throw new RuntimeException("Jump target out of range: " + target + " (code len=" + codeLen + ")");
        }
    }

    static final class GetIC {
        final Shape shape;
        final String key;
        final int slot;

        GetIC(Shape shape, String key, int slot) {
            this.shape = shape;
            this.key = key;
            this.slot = slot;
        }
    }

    static final class SetIC {
        final Shape shape;
        final String key;
        final int slot;

        SetIC(Shape shape, String key, int slot) {
            this.shape = shape;
            this.key = key;
            this.slot = slot;
        }
    }

    static {
        // Boxing values
        BOXER.put(Long.class, o -> new VLong((Long) o));
        BOXER.put(BigInteger.class, o -> new VBigInteger((BigInteger) o));
        BOXER.put(String.class, o -> new VString((String) o));
        BOXER.put(Boolean.class, o -> new VBool((Boolean) o));
        BOXER.put(null, o -> Value.NULL);

        // Caller tries to box a boxed element
        BOXER.put(VLong.class, o -> (Value) o);
        BOXER.put(VBigInteger.class, o -> (Value) o);
        BOXER.put(VString.class, o -> (Value) o);
        BOXER.put(VBool.class, o -> (Value) o);
        BOXER.put(VObject.class, o -> (Value) o);
        BOXER.put(VNull.class, o -> Value.NULL);
        BOXER.put(VFunction.class, o -> (Value) o);
        BOXER.put(VType.class, o -> (Value) o);

        // Unboxing
//        UNBOXER.put(VLong.class, (ConstantUnboxer<VLong>) VLong::v);
//        UNBOXER.put(VString.class, (ConstantUnboxer<VString>) VString::v);
//        UNBOXER.put(VBool.class, (ConstantUnboxer<VBool>) VBool::v);
//        UNBOXER.put(VNull.class, (ConstantUnboxer<VNull>) VNull::v);
//        UNBOXER.put(VObject.class, (ConstantUnboxer<VObject>) VObject::v);
    }

//    private static <V extends Value> ConstantUnboxer<V> findUnboxer(Class<? extends Value> cls) {
//        ConstantUnboxer<?> u = UNBOXER.get(cls);
//        if (u != null) return (ConstantUnboxer<V>) u;
//        for (Map.Entry<Class<? extends Value>, ConstantUnboxer<? extends Value>> e : UNBOXER.entrySet()) {
//            if (e.getKey().isAssignableFrom(cls)) return (ConstantUnboxer<V>) e.getValue();
//        }
//        throw new IllegalArgumentException("No unboxer for value class: " + cls.getName());
//    }
//
//    public static Object unbox(Value v) {
//        if (v == null || v == Value.NULL) return null;
//        return findUnboxer(v.getClass()).unbox(v);
//    }

    // Data for the perfect functioning of interpreter
    private final String fName;
    private Map<String, RootCallTarget> functionTable = new HashMap<>();
    private final List<Object> constantPool;
    private final byte[] code;

    // Inline Caching + Object storage
    private final HashMap<Integer, GetIC> getICs = new HashMap<>();
    private final HashMap<Integer, SetIC> setICs = new HashMap<>();
    private int getIChits = 0, getICmisses = 0, setIChits = 0, setICmisses = 0;


    private final JITCompiler compiler;

    public BciTracer tracer;

    public void setTracer(BciTracer t) {
        tracer = t;
    }

    public ToyBciLoop(String fName, byte[] code, List<Object> pool) {
        this.fName = fName;
        this.code = code;
        this.constantPool = pool;
        this.compiler = new JITCompiler();
    }

    @Override
    public final List<Object> getPool() {
        return constantPool;
    }

    @Override
    public final byte[] getCode() {
        return code;
    }


    private int opPUSH_I64(int pc, Stack stack) {
        long imm = ByteBuffer.wrap(code, pc, 8).order(ByteOrder.LITTLE_ENDIAN).getLong();
        stack.pushLong(imm);
        return pc + 8;
    }

    private int opPUSH_K(int pc, Stack stack) {
        short idx = CompileContext.undoU16(code, pc);
        Object rawConstant = constantPool.get(idx);

        ConstantBoxer translator = BOXER.get(rawConstant.getClass());

        if (translator == null)
            throw new RuntimeException("Unsupported constant type: " + rawConstant.getClass().getSimpleName());

        Value value = translator.box(rawConstant);
        stack.push(value);
        return pc + 2;
    }


    private int opPUSH_F(int pc, Stack stack) {
        short idx = CompileContext.undoU16(code, pc);
        Object rawConstant = constantPool.get(idx);

        if (!(rawConstant instanceof String))
            throw new RuntimeException("A function name is needed to push a function onto stack!");

        String fName = (String) rawConstant;
        RootCallTarget rt = functionTable.get(fName);

        // if (rt == null) throw new ToySyntaxErrorException("Unkown object: \"" + fName + "\"");

        VFunction f = VFunction.getFunction(fName, rt);
        stack.push(f);

        return pc + 2;
    }

    private void opADD(Stack stack) {
        Value r = stack.pop();
        Value l = stack.pop();

        try {
            stack.push(l.add(r));
        } catch (UnsupportedOperationException e) {
            throw new RuntimeException("Type error: " + e.getMessage());
        }
    }

    private void opSUB(Stack stack) {
        Value r = stack.pop();
        Value l = stack.pop();

        try {
            stack.push(l.sub(r));
        } catch (UnsupportedOperationException e) {
            throw new RuntimeException("Type error: " + e.getMessage());
        }
    }


    private void opMUL(Stack stack) {
        Value r = stack.pop();
        Value l = stack.pop();

        try {
            stack.push(l.mul(r));
        } catch (RuntimeException e) {
            throw new RuntimeException("Type error: " + e.getMessage());
        }
    }


    private void opDIV(Stack stack) {
        Value r = stack.pop();
        Value l = stack.pop();

        try {
            stack.push(l.div(r));
        } catch (RuntimeException e) {
            throw e;
        }
    }

    private void opNEG(Stack stack) {
        Value v = stack.pop().neg();
        stack.push(v);
    }

    private void opAND(Stack stack) {
        VBool b1 = (VBool) stack.pop();
        VBool b2 = (VBool) stack.pop();

        stack.push(new VBool(b1.v() && b2.v()));
    }

    private void opAND_L(Stack stack) {
        Value v = stack.peek();

        if (!(v instanceof VBool))
            throw new ToySyntaxErrorException("Type error: operation \"&&\" not defined for " + v.toErrString() + ", ANY");
    }

    private void opAND_R(Stack stack) {
        Value v = stack.peek();

        if (!(v instanceof VBool))
            throw new ToySyntaxErrorException("Type error: operation \"&&\" not defined for Boolean true, " + v.toErrString());
    }

    private void opOR_L(Stack stack) {
        Value v = stack.peek();

        if (!(v instanceof VBool))
            throw new ToySyntaxErrorException("Type error: operation \"||\" not defined for " + v.toErrString() + ", ANY");
    }

    private void opOR_R(Stack stack) {
        Value v = stack.peek();

        if (!(v instanceof VBool))
            throw new ToySyntaxErrorException("Type error: operation \"||\" not defined for Boolean false, " + v.toErrString());
    }

    private void opOR(Stack stack) {
        VBool b1 = (VBool) stack.pop();
        VBool b2 = (VBool) stack.pop();

        stack.push(new VBool(b1.v() || b2.v()));
    }


    private int opJMP(int pc) {
        int addr = CompileContext.undoI32(code, pc);
        checkAddr(addr, code.length);
        return addr;
    }

    private int opJNE(int pc, Stack stack) {
        Value v = stack.pop();

        int addr = CompileContext.undoI32(code, pc);
        checkAddr(addr, code.length);

        if (!(v instanceof VBool))
            throw new ToySyntaxErrorException("Type error: operation \"if\" not defined for " + v.toErrString());

        if (!((VBool) v).v()) {
            checkAddr(addr, code.length);
            return addr;
        }

        return pc + 4;
    }

    private void opEQ(Stack stack) {
        Value r = stack.pop();
        Value l = stack.pop();

        try {
            stack.push(l.eq(r));
        } catch (UnsupportedOperationException e) {
            throw new RuntimeException("Type error: " + e.getMessage());

        }
    }


    private void opNOT(Stack stack) {
        Value v = stack.pop();

        if (!(v instanceof VBool))
            throw new RuntimeException("Type error: NOT operation must be performed over and VBool but instead" + v.getClass().getSimpleName());

        stack.push(new VBool(!((VBool) v).v()));
    }

    private void opLT(Stack stack) {
        Value r = stack.pop();
        Value l = stack.pop();

        try {
            stack.push(l.lt(r));
        } catch (UnsupportedOperationException e) {
            throw new RuntimeException("Type error: " + e.getMessage());

        }
    }

    private void opLE(Stack stack) {
        Value r = stack.pop();
        Value l = stack.pop();

        try {
            stack.push(l.le(r));
        } catch (UnsupportedOperationException e) {
            throw new RuntimeException("Type error: " + e.getMessage());

        }
    }

    private int opSTR_K(int pc, Stack stack, Locals locals) {
        Value value = stack.pop();
        short slot = CompileContext.undoU16(code, pc);
        locals.set(slot, value);
        return pc + 2;
    }

    private int opLOAD_ARG(int pc, VirtualFrame frame, Stack stack) {
        short idx = CompileContext.undoU16(code, pc);

        Object rawObject = frame.get(idx);

        ConstantBoxer translator = BOXER.get(rawObject.getClass());

        if (translator == null)
            throw new RuntimeException("Unsupported argument type: " + rawObject.getClass().getSimpleName());

        stack.push(translator.box(rawObject));
        return pc + 2;
    }

    private int opLOAD_L(int pc, Stack stack, Locals locals) {
        short slot = CompileContext.undoU16(code, pc);
        stack.push(locals.get(slot));

        return pc + 2;
    }

    private void opSETPROP(int pc, Stack stack) {
        Value v = stack.pop();
        Value k = stack.pop();
        Value raw_o = stack.pop();

        if (!(raw_o instanceof VObject))
            throw new ToySyntaxErrorException("Undefined property: " + k);

        final String key = VObject.toKeyString(k);
        VObject obj = (VObject) raw_o;

        SetIC ic = setICs.get(pc);
        if (INLINE_CACHING && ic != null && obj.shape() == ic.shape && ic.key.equals(key)) {
            obj.setFast(ic.slot, v);
            setIChits++;
            return;
        }

        obj.set(key, v);
        if (INLINE_CACHING) {
            setICs.put(pc, new SetIC(obj.shape(), key, obj.shape().slotOf(key)));
            setICmisses++;
        }
    }

    private void opGETPROP(int pc, Stack stack) {
        Value k = stack.pop();
        Value raw_o = stack.pop();

        if (!(raw_o instanceof VObject))
            throw new ToySyntaxErrorException("Undefined property: " + k.toString());

        VObject obj = (VObject) raw_o;
        final String key = VObject.toKeyString(k);

        GetIC ic = getICs.get(pc);
        if (INLINE_CACHING && ic != null && obj.shape() == ic.shape && ic.key.equals(key)) {
            stack.push(obj.getFast(ic.slot));
            getIChits++;
            return;
        }

        Value v = obj.get(key); // -> This might throw error if it doesn't exist the property.
        stack.push(v);

        if (INLINE_CACHING) {
            getICs.put(pc, new GetIC(obj.shape(), key, obj.shape().slotOf(key)));
            getICmisses++;
        }
    }

    private int opCALL(int pc, Stack stack) {
        Value v = stack.pop();
        int argp = CompileContext.undoU16(code, pc);

        if (!(v instanceof VFunction))
            throw new ToySyntaxErrorException("Undefined function: " + v);

        RootCallTarget target = ((VFunction) v).v();

        if (target == null)
            throw new ToySyntaxErrorException("Undefined function: " + ((VFunction) v).getName());

        int argc = target.getArity();
        Object[] args = new Object[argc];

        int k = argp - argc;

        if (k >= 0) {
            while (k-- > 0) stack.pop();
            for (int i = argc - 1; i >= 0; i--) {
                args[i] = stack.pop();
            }
        } else {
            // throw new RuntimeException("Function " + target.getName() + " expects " + argc + " args, provided only " + argp); -> what should be...
            if (argp > 0) {
                for (int i = argp - 1; i >= 0; i--) {
                    args[i] = stack.pop();
                }
            }

            for (int i = argp; i < argc; i++) {
                args[i] = Value.NULL;
            }
        }

        try {
            Object object = target.invoke(args);
            stack.push(object == null ? Value.NULL : BOXER.get(object.getClass()).box(object));
        } catch (ToySyntaxErrorException e) {
            String msg = e.getMessage();

            if (msg.startsWith("Exception occurred, see trace.log for more info")) throw e;
            if (msg.startsWith("Not a string: cannot substring")) throw e;
            if (msg.startsWith("Type error")) throw e;
            if (msg.startsWith("Undefined function:")) throw e;
            if (msg.startsWith("Not an object!")) throw e;

            if (!msg.startsWith("Runtime error on"))
                throw new ToySyntaxErrorException("Runtime error on \"" + ((VFunction) v).getName() + "\": " + msg);
            throw e;
        }

        return pc + 2;
    }

    public Object execute(VirtualFrame frame) {
        int pc = 0;

        final Locals locals = new Locals(LOCALS_SLOTS);
        final Stack stack = new Stack();

//        int executions = 0;
//        Object objRegister = null;
//        int intRegister1 = 41;
//        int intRegister2 = 1;
        while (true) {
            int addr = pc;
            byte op = code[pc++];
            if (tracer != null) tracer.onExec(addr, op, stack.view());


            switch (op) {
//                case 42 -> {
//                    if (executions <= JIT_COMPILATION_THRESHOLD) {
//                        continue;
//                    }
//                    objRegister = compiler.compileAndRun(intRegister1, intRegister2);
//                    return "Hello from your friendly BCI! (and your JIT: " + objRegister + ")";
//                }
                case OpCode.PUSH_I64 -> pc = opPUSH_I64(pc, stack);
                case OpCode.PUSH_K -> pc = opPUSH_K(pc, stack);
                case OpCode.PUSH_F -> pc = opPUSH_F(pc, stack);
                case OpCode.PUSH_NULL -> stack.push(Value.NULL);
                case OpCode.POP -> {
                    if (!stack.isEmpty()) stack.pop();
                }
                case OpCode.ADD -> opADD(stack);
                case OpCode.SUB -> opSUB(stack);
                case OpCode.MUL -> opMUL(stack);
                case OpCode.DIV -> opDIV(stack);
                case OpCode.NEG -> opNEG(stack);
                case OpCode.AND -> opAND(stack);
                case OpCode.AND_L -> opAND_L(stack);
                case OpCode.AND_R -> opAND_R(stack);
                case OpCode.OR_L -> opOR_L(stack);
                case OpCode.OR_R -> opOR_R(stack);
                case OpCode.OR -> opOR(stack);
                case OpCode.JMP -> pc = opJMP(pc);
                case OpCode.JNE -> pc = opJNE(pc, stack);
                case OpCode.LT -> opLT(stack);
                case OpCode.LE -> opLE(stack);
                case OpCode.EQ -> opEQ(stack);
                case OpCode.NOT -> opNOT(stack);
                case OpCode.LOAD_ARG -> pc = opLOAD_ARG(pc, frame, stack);
                case OpCode.LOAD_L -> pc = opLOAD_L(pc, stack, locals);
                case OpCode.STR_K -> pc = opSTR_K(pc, stack, locals);
                case OpCode.SETPROP -> opSETPROP(pc, stack);
                case OpCode.GETPROP -> opGETPROP(pc, stack);
                case OpCode.CALL -> pc = opCALL(pc, stack);
                case OpCode.RET -> {
                    if (INLINE_CACHING) {
                        System.out.println("--------------------------------------------------------\n" +
                            "Inline Cache Report:\n" +
                            "GetIC hits: " + getIChits + ", GetIC misses: " + getICmisses + "\n" +
                            "SetIC hits: " + setIChits + ", SetIC misses: " + setICmisses + "\n");
                    }


                    return stack.isEmpty() ? Value.NULL : stack.pop();
                }
                // case ..
                default -> throw new RuntimeException("TODO: Not implemented opcode");
            }


        }
        // return whatever;
    }

    @Override
    public void setFunctionTable(Map<String, RootCallTarget> tb) {
        this.functionTable = tb;
    }
}
