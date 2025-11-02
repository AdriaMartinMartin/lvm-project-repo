package nl.tue.vmcourse.toy.bci;

import nl.tue.vmcourse.toy.interpreter.ToyAbstractFunctionBody;
import nl.tue.vmcourse.toy.lang.RootCallTarget;

import java.io.PrintStream;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.util.List;

public class BciDisassembler {
    private BciDisassembler() {
    }

    public static void dump(RootCallTarget rc, PrintStream out) {
        out.println("Dumped BCI for function <" + rc.getName() + ">:");
        out.println("------------------------------------------------------------");

        byte[] code = rc.getCode();
        List<Object> pool = rc.getPool();
        int pc = 0;

        while (pc < code.length) {
            int off = pc;
            int op = code[pc++];

            switch (op) {
                case OpCode.PUSH_I64 -> {
                    long imm = ByteBuffer.wrap(code, pc, 8).order(ByteOrder.LITTLE_ENDIAN).getLong();
                    out.printf("%04x: %-12s %d%n", off, "PUSH_I64", imm);
                    pc += 8;
                }
                case OpCode.PUSH_K -> {
                    short idx = ByteBuffer.wrap(code, pc, 2).order(ByteOrder.LITTLE_ENDIAN).getShort();
                    pc += 2;
                    Object c = pool.get(idx);
                    out.printf("%04x: %-12s %d  ; %s%n", off, "PUSH_K", idx, printable(c));
                }
                case OpCode.PUSH_F -> {
                    short idx = ByteBuffer.wrap(code, pc, 2).order(ByteOrder.LITTLE_ENDIAN).getShort();
                    pc += 2;
                    Object c = pool.get(idx);
                    out.printf("%04x: %-12s %d  ; %s%n", off, "PUSH_F", idx, printable(c));
                }
                case OpCode.PUSH_NULL -> out.printf("%04x: %-12s%n", off, "PUSH_NULL");
                case OpCode.POP -> out.printf("%04x: %-12s%n", off, "POP");
                case OpCode.ADD -> out.printf("%04x: %-12s%n", off, "ADD");
                case OpCode.SUB -> out.printf("%04x: %-12s%n", off, "SUB");
                case OpCode.MUL -> out.printf("%04x: %-12s%n", off, "MUL");
                case OpCode.DIV -> out.printf("%04x: %-12s%n", off, "DIV");
                case OpCode.NEG -> out.printf("%04x: %-12s%n", off, "NEG");
                case OpCode.AND -> out.printf("%04x: %-12s%n", off, "AND");
                case OpCode.AND_L -> out.printf("%04x: %-12s%n", off, "AND_L");
                case OpCode.AND_R -> out.printf("%04x: %-12s%n", off, "AND_R");
                case OpCode.OR_L -> out.printf("%04x: %-12s%n", off, "OR_L");
                case OpCode.OR_R -> out.printf("%04x: %-12s%n", off, "OR_R");
                case OpCode.OR -> out.printf("%04x: %-12s%n", off, "OR");
                case OpCode.NOT -> out.printf("%04x: %-12s%n", off, "NOT");
                case OpCode.SETPROP -> out.printf("%04x: %-12s%n", off, OpCode.nameOf(OpCode.SETPROP));
                case OpCode.GETPROP -> out.printf("%04x: %-12s%n", off, OpCode.nameOf(OpCode.GETPROP));
                case OpCode.JMP -> {
                    int target = ByteBuffer.wrap(code, pc, 4).order(ByteOrder.LITTLE_ENDIAN).getInt();
                    out.printf("%04x: %-12s 0x%04x%n", off, "JMP", target);
                    pc += 4;
                }
                case OpCode.JNE -> {
                    int target = ByteBuffer.wrap(code, pc, 4).order(ByteOrder.LITTLE_ENDIAN).getInt();
                    out.printf("%04x: %-12s 0x%04x%n", off, "JNE", target);
                    pc += 4;
                }
                case OpCode.LT -> out.printf("%04x: %-12s%n", off, "LT");
                case OpCode.LE -> out.printf("%04x: %-12s%n", off, "LE");
                case OpCode.EQ -> out.printf("%04x: %-12s%n", off, "EQ");
                case OpCode.LOAD_ARG -> {
                    int idx = ((code[pc] & 0xFF) | ((code[pc + 1] & 0xFF) << 8));
                    pc += 2;
                    out.printf("%04x: %-12s %d%n", off, "LOAD_ARG", idx);
                }
                case OpCode.LOAD_L -> {
                    int slot = ((code[pc] & 0xFF) | ((code[pc + 1] & 0xFF) << 8));
                    pc += 2;
                    out.printf("%04x: %-12s %d%n", off, "LOAD_L", slot);
                }
                case OpCode.STR_K -> {
                    int slot = ((code[pc] & 0xFF) | ((code[pc + 1] & 0xFF) << 8));
                    pc += 2;
                    out.printf("%04x: %-12s %d%n", off, "STR_K", slot);
                }
                case OpCode.CALL -> {
                    int argc = ByteBuffer.wrap(code, pc, 2).order(ByteOrder.LITTLE_ENDIAN).getShort();
                    pc += 2;
                    out.printf("%04x: %-12s argc=%d%n", off, "CALL", argc);
                }
                case OpCode.RET -> out.printf("%04x: %-12s%n", off, "RET");
                default -> out.printf("%04x: %-12s 0x%02X%n", off, "UNKNOWN", op);
            }
        }
        out.println("------------------------------------------------------------");
    }

    private static String printable(Object o) {
        if (o == null) return "null";
        if (o instanceof String) {
            String s = (String) o;
            String shortS = s.length() > 40 ? s.substring(0, 37) + "..." : s;
            return '"' + shortS.replace("\n", "\\n") + '"';
        }
        return String.valueOf(o);
    }
}
