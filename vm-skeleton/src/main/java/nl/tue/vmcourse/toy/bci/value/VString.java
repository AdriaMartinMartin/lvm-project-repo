package nl.tue.vmcourse.toy.bci.value;

import java.util.Objects;

import nl.tue.vmcourse.toy.interpreter.ToySyntaxErrorException;

public final class VString implements Value {
    private final String v;

    public VString(String v) {
        this.v = v;
    }

    public String v() {
        return v;
    }

    @Override
    public Value add(Value r) {
        if (r instanceof VFunction)
            throw new ToySyntaxErrorException("Type error: operation \"+\" not defined for " + toErrString() + ", " + r.toErrString());
        else if (r instanceof VObject)
            return new VString(v + "[foreign object]");
//        throw new UnsupportedOperationException("Cannot add VString to " + r.getClass().getSimpleName());
        return new VString(v + r);
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
        throw new ToySyntaxErrorException("Type error: operation \"<\" not defined for String \"" + v + "\", " + new VType(r) + "\"" + r + "\"");
    }

    @Override
    public Value le(Value r) {
        throw new ToySyntaxErrorException("Type error: operation \"<=\" not defined for " + toErrString() + ", " + r.toErrString());
    }

    @Override
    public Value eq(Value r) {
        if (r instanceof VString) {
            return new VBool(Objects.equals(v, ((VString) r).v()));
        }

        return new VBool(false);
    }

    @Override
    public int length() {
        return v.length();
    }

    @Override
    public void print() {
        System.out.println(v);
    }

    @Override
    public String toString() {
        return v;
    }

    @Override
    public String toErrString() {
        return "String \"" + v + "\"";
    }


}
