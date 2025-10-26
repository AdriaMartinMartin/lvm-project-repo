package nl.tue.vmcourse.toy.bci;

import nl.tue.vmcourse.toy.bci.value.ConstantTranslator;
import nl.tue.vmcourse.toy.bci.value.VLong;
import nl.tue.vmcourse.toy.bci.value.VString;
import nl.tue.vmcourse.toy.bci.value.Value;
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
    private Map<String, RootCallTarget> functionTable = new HashMap<>();

    static {
        TRANSLATOR_MAP.put(Long.class, item -> new VLong((Long) item));
        TRANSLATOR_MAP.put(String.class, item -> new VString((String) item));
        TRANSLATOR_MAP.put(VLong.class, item -> (Value) item);
        TRANSLATOR_MAP.put(VString.class, item -> (Value) item);
    }

    private final Locals locals = new Locals(LOCALS_SLOTS);
    private final Stack stack = new Stack();
    private final List<Object> constantPool;
    private final byte[] code;

    private final JITCompiler compiler;

    public ToyBciLoop(byte[] code, List<Object> pool) {
        this.code = code;
        this.constantPool = pool;
        this.compiler = new JITCompiler();
    }

    private int opPUSH_I64(int pc) {
        long imm = ByteBuffer.wrap(code, pc, 8).order(ByteOrder.LITTLE_ENDIAN).getLong();
        stack.pushLong(imm);
        return pc + 8;
    }

    private int opPUSH_K(int pc) {
        short idx = CompileContext.undoU16(code, pc);
        Object rawConstant = constantPool.get(idx);

        ConstantTranslator translator = TRANSLATOR_MAP.get(rawConstant.getClass());

        if (translator == null)
            throw new RuntimeException("Unsupported constant type: " + rawConstant.getClass().getSimpleName());

        Value value = translator.box(rawConstant);
        stack.push(value);
        return pc + 2;
    }

    private void opADD() {
        Value l = stack.pop();
        Value r = stack.pop();

        try {
            stack.push(l.add(r));
        } catch (UnsupportedOperationException e) {
            throw new RuntimeException("Type error: " + e.getMessage());
        }
    }

    private int  opSTR_K(int pc) {
        Value value = stack.pop();
        short slot = CompileContext.undoU16(code, pc);
        System.out.println(slot);
        locals.set(slot, value);
        return pc + 2;
    }

    private int opLOAD_ARG(int pc, VirtualFrame frame) {
        short idx = CompileContext.undoU16(code, pc);
        System.out.println(idx);

        Object rawObject = frame.get(idx);

        ConstantTranslator translator = TRANSLATOR_MAP.get(rawObject.getClass());

        if (translator == null)
            throw new RuntimeException("Unsupported argument type: " + rawObject.getClass().getSimpleName());

        stack.push(translator.box(rawObject));
        return pc + 2;
    }

    private int opLOAD_L(int pc) {
        short slot = CompileContext.undoU16(code, pc);
        System.out.println(slot);
        stack.push(locals.get(slot));

        return pc + 2;
    }

    private int opCALL(int pc) {
        int poolIdx = CompileContext.undoU16(code, pc);
        int argp = CompileContext.undoU16(code, pc + 2);
        System.out.println(" " + poolIdx);

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
        else if (k < 0) throw new RuntimeException("Function " + target.getName() + " expects " + argc + " args, provided only " + argp);

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
//        int executions = 0;
//        Object objRegister = null;
//        int intRegister1 = 41;
//        int intRegister2 = 1;
        while (true) {
//            executions++;
            switch (code[pc++]) {
//                case 42 -> {
//                    if (executions <= JIT_COMPILATION_THRESHOLD) {
//                        continue;
//                    }
//                    objRegister = compiler.compileAndRun(intRegister1, intRegister2);
//                    return "Hello from your friendly BCI! (and your JIT: " + objRegister + ")";
//                }
                case OpCode.PUSH_I64 -> {
                    System.out.println("PUSH_I64");
                    pc = opPUSH_I64(pc);
                }
                case OpCode.PUSH_K -> {
                    System.out.println("PUSH_K");
                    pc = opPUSH_K(pc);
                }
                case OpCode.PUSH_NULL -> {
                    System.out.println("PUSH_NULL");
                    stack.push(Value.NULL);
                }
                case OpCode.ADD -> {
                    System.out.println("ADD");
                    opADD();
                }
                case OpCode.LOAD_ARG -> {
                    System.out.print("LOAD_ARG ");
                    pc = opLOAD_ARG(pc, frame);
                }
                case OpCode.LOAD_L -> {
                    System.out.print("LOAD_L ");
                    pc = opLOAD_L(pc);
                }
                case OpCode.STR_K -> {
                    System.out.print("STR_K ");
                    pc = opSTR_K(pc);
                }
                case OpCode.CALL -> {
                    System.out.print("CALL");
                    pc = opCALL(pc);
                }
                case OpCode.RET -> {
                    System.out.print("RET ");
                    Value v = stack.isEmpty() ? null : stack.pop();

                    if (v != null ) {
                        v.print();
                    } else {
                        System.out.println("");
                    }

                    return v;
                }
                case OpCode.HALT -> {
                    System.out.println("HALT");
                    return null;
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
