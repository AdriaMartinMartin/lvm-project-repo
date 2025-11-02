package nl.tue.vmcourse.toy.bci.value;

import nl.tue.vmcourse.toy.interpreter.ToySyntaxErrorException;

public class VBool implements Value {
    private final boolean v;

    public VBool(boolean v) {
        this.v = v;
    }

    public final boolean v() {
        return v;
    }

    @Override
    public Value add(Value r) {
        if (r instanceof VString)
            return new VString(String.valueOf(v) + r);

        throw new ToySyntaxErrorException("Type error: operation \"+\" not defined for " + toErrString() + ", " + r.toErrString());
    }

    @Override
    public Value sub(Value r) {
        throw new ToySyntaxErrorException("Type error: operation \"-\" not defined for " + toErrString() + ", " + r.toErrString());
    }

    @Override
    public Value mul(Value r) {
        throw new ToySyntaxErrorException("Type error: operation \"*\" not defined for " + toErrString() + ", " + r.toErrString());
    }

    @Override
    public Value div(Value r) {
        throw new ToySyntaxErrorException("Type error: operation \"/\" not defined for " + toErrString() + ", " + r.toErrString());
    }


    @Override
    public Value neg() {
        throw new ToySyntaxErrorException("Runtime error on \"-\": Unary operation only defined for numbers");
    }

    @Override
    public Value lt(Value r) {
        throw new ToySyntaxErrorException("Type error: operation \"<\" not defined for " + toErrString() + ", " + r.toErrString());
    }

    @Override
    public Value le(Value r) {
        throw new ToySyntaxErrorException("Type error: operation \"<=\" not defined for " + toErrString() + ", " + r.toErrString());
    }


    @Override
    public Value eq(Value r) {
        if (r instanceof VBool)
            return new VBool(v == ((VBool) r).v());

        return new VBool(false);
    }

    @Override
    public int length() {
        throw new ToySyntaxErrorException("Element is not a valid array.");
    }

    @Override
    public void print() {
        System.out.println(v);
    }

    @Override
    public String toString() {
        return String.valueOf(v);
    }

    @Override
    public String toErrString() {
        return "Boolean" + v;
    }
}
