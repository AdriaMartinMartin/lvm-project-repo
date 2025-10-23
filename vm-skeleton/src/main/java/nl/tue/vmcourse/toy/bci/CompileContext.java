package nl.tue.vmcourse.toy.bci;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public final class CompileContext {
    private final BytecodeBuffer code = new BytecodeBuffer();
    private final List<Object> constantPool = new ArrayList<Object>();

    public static class FunctionInfo {
        public final String name;
        public final int offsetPC;
        public final int arity;

        public FunctionInfo(String name, int offsetPC, int arity) {
            this.name = name;
            this.offsetPC = offsetPC;
            this.arity = arity;
        }
    }

    public int position() {
        return code.position();
    }

    public void emit(byte op) {
        code.emit(op);
    }

    public void emitI32(int v) {
        code.emitI32(v);
    }

    public void emitI64(long v) {
        code.emitI64(v);
    }

    public byte[] toBytecode() {
        return code.toBytecode();
    }
}