package nl.tue.vmcourse.toy.bci;

public final class OpCode {
    private OpCode() {
    }

    public static final byte HALT = 0x00;
    public static final byte CALL = 0x70;
    public static final byte RETURN = 0x71;

    // Stack operations
    public static final byte PUSH_I64 = 0x01;
    public static final byte PUSH_S = 0x02;
    public static final byte PUSH_K = 0X03;
    public static final byte POP = 0x04;

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
    public static final byte JMF = 0x21;

    public static final byte LT = 0x22;
    public static final byte LE = 0x23;
    public static final byte EQ = 0x24;
    public static final byte NOT = 0x25;

    // Local/args
    public static final byte LOCAL_L = 0x30;
    public static final byte STORE_L = 0x31;
}