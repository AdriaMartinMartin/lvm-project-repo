package nl.tue.vmcourse.toy.bci;

import java.io.ByteArrayOutputStream;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.util.ArrayList;
import java.util.List;

/**
 * Utility for emitting Toy VM bytecode instructions into a contiguous
 * byte buffer. Provides simple primitives for writing opcodes and
 * their operands, reserving and patching integer fields, and finally
 * retrieving the resulting byte array.
 */
public final class BytecodeBuffer {
    /** Internal growable output stream holding the emitted bytes. */
    private final ByteArrayOutputStream out = new ByteArrayOutputStream();

    /**
     * Returns the current write position (in bytes) within the buffer.
     *
     * @return the number of bytes written so far
     */
    public int position() {
        return out.size();
    }

    /**
     * Emits a single byte to the buffer. Usually used for writing opcodes
     * or small immediates.
     *
     * @param b the byte value to write
     */
    public void emit(byte b) {
        out.write(b);
    }

    /**
     * Emits a 32-bit signed integer in little-endian order
     * (least significant byte first).
     *
     * @param v the integer value to write
     */
    public void emitI32(int v) {
        byte[] bytes = ByteBuffer.allocate(4).order(ByteOrder.LITTLE_ENDIAN).putInt(v).array();
        out.writeBytes(bytes);
    }

    /**
     * Emits a 64-bit signed integer in little-endian order
     * (least significant byte first).
     *
     * @param v the integer value to write
     */
    public void emitI64(long v) {
        byte[] bytes = ByteBuffer.allocate(8).order(ByteOrder.LITTLE_ENDIAN).putLong(v).array();
        out.writeBytes(bytes);
    }

    /**
     * Emits a 16-bit unsigned integer in little-endian order
     * (least significant byte first).
     *
     * @param v the unsigned 16-bit value to write
     */
    public void emitU16(short v) {
        out.write(v & 0xFF);
        out.write((v >>> 8) & 0xFF);
    }

    /**
     * Returns a copy of all bytes written so far as a byte array.
     * This represents the finalized bytecode sequence.
     *
     * @return the complete bytecode as a new byte array
     */
    public byte[] toBytecode() {
        return out.toByteArray();
    }

    /**
     * Patches a previously emitted 32-bit integer at the specified
     * absolute position with a new value, writing it in little-endian
     * order. This is typically used to back-patch relative jump offsets
     * once their target positions are known.
     *
     * @param pos   the absolute byte offset where the 4-byte integer begins
     * @param value the new integer value to write at that position
     */
    public void patchI32(int pos, int value) {
        byte[] data = out.toByteArray();
        byte[] patch = ByteBuffer.allocate(4).order(ByteOrder.LITTLE_ENDIAN).putInt(value).array();
        System.arraycopy(patch, 0, data, pos, 4);
        out.reset();
        out.writeBytes(data);
    }
}
