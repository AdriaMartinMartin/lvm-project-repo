package nl.tue.vmcourse.toy.bci.value;

public class VBool implements Value {
    private final boolean v;

    public VBool(boolean v) {
        this.v = v;
    }

    public final boolean v() { return v; }

    @Override
    public Value add(Value r) {
        if (r instanceof VString)
            return new VString(String.valueOf(v) + r);

        throw new RuntimeException("Cannot add VBool to " + r.getClass().getSimpleName());
    }

    @Override
    public Value sub(Value r) {
        throw new RuntimeException("Cannot do subtract operations with VBool");
    }

    @Override
    public Value mul(Value r) { throw new RuntimeException("Cannot do multiplication with VBoool"); }

    @Override
    public Value div(Value r) { throw new RuntimeException("Cannot do division with VBoool"); }


    @Override
    public Value neg() {
        throw new RuntimeException("Error on \"-\": Unary operation only defined for numbers");
    }

    @Override
    public Value lt(Value r) { throw new RuntimeException("Cannot do less than operation with VBool"); }

    @Override
    public Value le(Value r) { throw new RuntimeException("Cannot do less equal operation with VBool"); }


    @Override
    public Value eq(Value r) {
        if (r instanceof VBool)
            return new VBool(v == ((VBool) r).v());

        return new VBool(false);
    }

    @Override
    public void print() {
        System.out.println(v);
    }

    @Override
    public String toString() {
        return String.valueOf(v);
    }
}
