package nl.tue.vmcourse.toy.bci;

import nl.tue.vmcourse.toy.bci.value.*;
import nl.tue.vmcourse.toy.interpreter.ToyAbstractFunctionBody;
import nl.tue.vmcourse.toy.lang.RootCallTarget;
import nl.tue.vmcourse.toy.lang.VirtualFrame;
import nl.tue.vmcourse.toy.jit.JITCompiler;

import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ToyBciLoop extends ToyAbstractFunctionBody {

    private static final int JIT_COMPILATION_THRESHOLD = 3;
    private static final int LOCALS_SLOTS = 16;
    private static final Map<Class<?>, ConstantTranslator> TRANSLATOR_MAP = new HashMap<>();

    private static void checkAddr(int target, int codeLen) {
        if (target < 0 || target > codeLen) {
            throw new RuntimeException("Jump target out of range: " + target + " (code len=" + codeLen + ")");
        }
    }

    static {
        TRANSLATOR_MAP.put(Long.class, item -> new VLong((Long) item));
        TRANSLATOR_MAP.put(String.class, item -> new VString((String) item));
        TRANSLATOR_MAP.put(Boolean.class, item -> new VBool((Boolean) item));
        TRANSLATOR_MAP.put(VLong.class, item -> (Value) item);
        TRANSLATOR_MAP.put(VString.class, item -> (Value) item);
        TRANSLATOR_MAP.put(VBool.class, item -> (Value) item);
        TRANSLATOR_MAP.put(VObject.class, item -> (Value) item);
        TRANSLATOR_MAP.put(null, item -> Value.NULL);
        TRANSLATOR_MAP.put(VNull.class, item -> Value.NULL);
        TRANSLATOR_MAP.put(Map.class, item -> {
            Map<?, ?> m = (Map<?, ?>) item;
            VObject o = new VObject();
            for (Map.Entry<?, ?> e : m.entrySet()) {
                String k = (e.getKey() instanceof Value) ? VObject.toKeyString((Value) e.getKey()) : String.valueOf(e.getKey());
                Value v = TRANSLATOR_MAP.get(e.getValue().getClass()).box(e.getValue());
                o.set(k, v);
            }

            return o;
        });
    }

    private Map<String, RootCallTarget> functionTable = new HashMap<>();
    private final List<Object> constantPool;
    private final byte[] code;

    private final JITCompiler compiler;

    public BciTracer tracer;

    public void setTracer(BciTracer t) {
        tracer = t;
    }

    public ToyBciLoop(byte[] code, List<Object> pool) {
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

        ConstantTranslator translator = TRANSLATOR_MAP.get(rawConstant.getClass());

        if (translator == null)
            throw new RuntimeException("Unsupported constant type: " + rawConstant.getClass().getSimpleName());

        Value value = translator.box(rawConstant);
        stack.push(value);
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

    private void opNEG(Stack stack) {
        Value v = stack.pop().neg();
        stack.push(v);
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
            throw new RuntimeException("Type error: operation \"if\" not defined for " + v.getClass().getSimpleName() + v);

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

    private void opLT(Stack stack) {
        Value r = stack.pop();
        Value l = stack.pop();

        try {
            stack.push(l.lt(r));
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

        ConstantTranslator translator = TRANSLATOR_MAP.get(rawObject.getClass());

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

    private void opSETPROP(Stack stack) {
        Value v = stack.pop();
        Value k = stack.pop();
        VObject o;

        try {
            o = (VObject) stack.pop();
            o.set(k, v);
        } catch (RuntimeException e) {
            throw new RuntimeException("Type error, accessing is only for Objects: " + e.getMessage());
        }
    }

    private void opGETPROP(Stack stack) {
        Value k = stack.pop();
        VObject o;

        try {
            o = (VObject) stack.pop();
            stack.push(o.get(k));
        } catch (RuntimeException e) {
            throw new RuntimeException("Type error, accessing is only for Objects: " + e.getMessage());
        }
    }

    private int opCALL(int pc, Stack stack) {
        int poolIdx = CompileContext.undoU16(code, pc);
        int argp = CompileContext.undoU16(code, pc + 2);

        if (!(constantPool.get(poolIdx) instanceof String))
            throw new RuntimeException("Bad type for function call. Expected: <String>, you provided: " + constantPool.get(poolIdx).getClass());

        String fName = (String) constantPool.get(poolIdx);

        RootCallTarget target = functionTable.get(fName);
        if (target == null) throw new RuntimeException("It doesn't exist a class with name: " + fName);

        int argc = target.getArity();
        Object[] args = new Object[argc];

        int k = argp - argc;

        if (k > 0)
            while (k-- > 0) stack.pop();
        else if (k < 0)
            throw new RuntimeException("Function " + target.getName() + " expects " + argc + " args, provided only " + argp);

        for (int i = argc - 1; i >= 0; i--) {
            args[i] = stack.pop();
        }

        Object object = target.invoke(args);
        if (object != null) {
            stack.push(TRANSLATOR_MAP.get(object.getClass()).box(object));
        }

        return pc + 4;
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

//            executions++;
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
                case OpCode.PUSH_NULL -> stack.push(Value.NULL);
                case OpCode.ADD -> opADD(stack);
                case OpCode.SUB -> opSUB(stack);
                case OpCode.MUL -> opMUL(stack);
                case OpCode.NEG -> opNEG(stack);
                case OpCode.JMP -> pc = opJMP(pc);
                case OpCode.JNE -> pc = opJNE(pc, stack);
                case OpCode.LT -> opLT(stack);
                case OpCode.EQ -> opEQ(stack);
                case OpCode.LOAD_ARG -> pc = opLOAD_ARG(pc, frame, stack);
                case OpCode.LOAD_L -> pc = opLOAD_L(pc, stack, locals);
                case OpCode.STR_K -> pc = opSTR_K(pc, stack, locals);
                case OpCode.SETPROP -> opSETPROP(stack);
                case OpCode.GETPROP -> opGETPROP(stack);
                case OpCode.CALL -> pc = opCALL(pc, stack);
                case OpCode.RET -> {
                    return stack.isEmpty() ? Value.NULL : stack.pop();
                }
                // case ..
                default -> throw new RuntimeException("TODO");
            }
        }
        // return whatever;
    }

    @Override
    public void setFunctionTable(Map<String, RootCallTarget> tb) {
        this.functionTable = tb;
    }
}
