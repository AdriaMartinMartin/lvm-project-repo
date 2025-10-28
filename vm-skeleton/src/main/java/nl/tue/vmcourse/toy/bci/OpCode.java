package nl.tue.vmcourse.toy.bci;

public final class OpCode {
    private OpCode() {
    }

    public static final byte CALL = 0x70;
    public static final byte RET = 0x71;

    // Stack operations
    public static final byte PUSH_I64 = 0x01;
    public static final byte PUSH_S = 0x02;
    public static final byte PUSH_K = 0X03;
    public static final byte POP = 0x04;
    public static final byte POP_N = 0x05;
    public static final byte PUSH_NULL = 0x06;

    // Arithmetic
    public static final byte ADD = 0x10;
    public static final byte ADD_I64 = 0x11;
    public static final byte ADD_1 = 0x12;
    public static final byte SUB = 0x13;
    public static final byte SUB_I64 = 0x14;
    public static final byte SUB_1 = 0x15;
    public static final byte MUL = 0x16;
    public static final byte MUL_I64 = 0x17;
    public static final byte DIV = 0x18;
    public static final byte DIV_I64 = 0x19;
    public static final byte NEG = 0x1A;

    // Control flow, comparisons...
    public static final byte JMP = 0x20;
    public static final byte JNE = 0x21;

    public static final byte LT = 0x22;
    public static final byte LE = 0x23;
    public static final byte EQ = 0x24;
    public static final byte NOT = 0x25;

    // Local/args
    public static final byte LOAD_ARG = 0x30;
    public static final byte LOAD_L = 0x31;
    public static final byte STR_I64 = 0x32;
    public static final byte STR_K = 0x33;

    // VObject set/get
    public static final byte SETPROP = 0x40;
    public static final byte GETPROP = 0x41;

    // Builtin, just trace and dump purposes
    public static final byte PRINTLN = 0x50;
    public static final byte NEW = 0x51;
    public static final byte GETSIZE = 0x52;


    public static Object nameOf(byte opcode) {
        return switch (opcode) {
            case CALL -> "CALL";
            case RET -> "RET";
            case PUSH_I64 -> "PUSH_I64";
            case PUSH_K -> "PUSH_K";
            case PUSH_NULL -> "PUSH_NULL";
            case ADD -> "ADD";
            case SUB -> "SUB";
            case MUL -> "MUL";
            case NEG -> "NEG";
            case JMP -> "JMP";
            case JNE -> "JNE";
            case LT -> "LT";
            case EQ -> "EQ";
            case LOAD_ARG -> "LOAD_ARG";
            case LOAD_L -> "LOAD_L";
            case STR_K -> "STR_K";
            case SETPROP -> "SETPROP";
            case GETPROP -> "GETPROP";
            case PRINTLN -> "PRINTLN";
            case NEW -> "NEW";
            case GETSIZE -> "GETSIZE";
            default -> "UNKNOWN";
        };
    }
}