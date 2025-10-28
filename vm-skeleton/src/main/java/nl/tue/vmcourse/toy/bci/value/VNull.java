package nl.tue.vmcourse.toy.bci.value;

public class VNull implements Value {
    private static final VNull instance = new VNull();

    private VNull() {};

    public static VNull getInstance() {
        return instance;
    }

    @Override
    public Value add(Value r) {
        if (r instanceof VString) {
            return new VString("NULL" + r);
        }

        throw new UnsupportedOperationException("Cannot add VNull to " + r.getClass().getSimpleName());
    }

    @Override
    public Value sub(Value r) {
        throw new RuntimeException("Cannot do subtract operations with NULL");
    }

    @Override
    public Value mul(Value r) { throw new RuntimeException("Cannot do multiplications with NULL"); }

    @Override
    public Value neg() {
        throw new RuntimeException("Error on \"-\": Unary operation only defined for numbers");
    }

    @Override
    public Value lt(Value r) { throw new RuntimeException("Cannot do less than operation with NULL"); }

    @Override
    public Value eq(Value r) {
        if (r instanceof VNull)
            return new VBool(true);

        return new VBool(false);
    }

    @Override
    public void print() {
        System.out.println("NULL");
    }

    @Override
    public String toString() {
        return "NULL";
    }
}
