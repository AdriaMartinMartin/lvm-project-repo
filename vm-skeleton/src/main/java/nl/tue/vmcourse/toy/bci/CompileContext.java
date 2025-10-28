package nl.tue.vmcourse.toy.bci;

import nl.tue.vmcourse.toy.bci.value.Value;

import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public final class CompileContext {
    private final BytecodeBuffer code = new BytecodeBuffer();

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

    private final List<Object> constantPool = new ArrayList<>();
    private final Map<Object, Short> poolIndex = new HashMap<>();

    public short addConstant(Object constant) {
        Short idx = poolIndex.get(constant);

        if (idx != null) {
            code.emitU16(idx);
            return idx;
        }

        if (constantPool.size() >= 65535) throw new RuntimeException("Constant pool overflow! More than 2^16 objects.");
        short nIdx = (short) constantPool.size();

        constantPool.add(constant);
        poolIndex.put(constant, nIdx);
        code.emitU16(nIdx);

        return nIdx;
    }

    public void emitU16(short idx) { code.emitU16(idx); }

    public static short undoU16(byte[] code, int pc) {
        return ByteBuffer.wrap(code, pc, 2).order(ByteOrder.LITTLE_ENDIAN).getShort();
    }
    public static int undoI32(byte[] code, int pc) {
        return ByteBuffer.wrap(code, pc, 4).order(ByteOrder.LITTLE_ENDIAN).getInt();
    }

    public void patchI32(int pos, int value) { code.patchI32(pos, value);}

    /**
     * Gets the finalized constant pool. The VM interpreter will need
     * this list to load constants at runtime.
     *
     * @return The list of constants.
     */
    public List<Object> getConstantPool() {
        return constantPool;
    }
}