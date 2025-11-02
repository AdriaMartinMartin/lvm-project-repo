package nl.tue.vmcourse.toy.bci.value;

import java.math.BigInteger;

import nl.tue.vmcourse.toy.interpreter.ToySyntaxErrorException;

public class VBigInteger implements Value {
    private final BigInteger v;

    public VBigInteger(BigInteger v) {
        this.v = v;
    }

    public final BigInteger v() {
        return v;
    }

    @Override
    public Value add(Value r) {
        if (r instanceof VString) return new VString(v + ((VString) r).v());
        if (r instanceof VLong) return new VBigInteger(v.add(BigInteger.valueOf(((VLong) r).v())));
        if (r instanceof VBigInteger) return new VBigInteger(v.add(((VBigInteger) r).v()));

        throw new ToySyntaxErrorException("Type error: operation \"+\" not defined for " + toErrString() + ", " + r.toErrString());
    }

    @Override
    public Value sub(Value r) {
        if (r instanceof VLong) return new VBigInteger(v.subtract(BigInteger.valueOf(((VLong) r).v())));
        if (r instanceof VBigInteger) return new VBigInteger(v.subtract(((VBigInteger) r).v));

        throw new ToySyntaxErrorException("Type error: operation \"-\" not defined for " + toErrString() + ", " + r.toErrString());
    }

    @Override
    public Value mul(Value r) {
        if (r instanceof VLong) return new VBigInteger(v.multiply(BigInteger.valueOf(((VLong) r).v())));
        if (r instanceof VBigInteger) return new VBigInteger(v.multiply(((VBigInteger) r).v));

        throw new ToySyntaxErrorException("Type error: operation \"*\" not defined for " + toErrString() + ", " + r.toErrString());
    }

    @Override
    public Value div(Value r) {
        if (r instanceof VLong) {
            if (((VLong) r).v() == 0)
                throw new ToySyntaxErrorException("Runtime error on \"/\": Division by zero");
            else
                return new VBigInteger(v.divide(BigInteger.valueOf(((VLong) r).v())));
        } else if (r instanceof VBigInteger) {
            if (((VBigInteger) r).v().equals(0))
                throw new ToySyntaxErrorException("Runtime error on \"/\": Division by zero");
            else
                return new VBigInteger(v.divide(((VBigInteger) r).v));
        }

        throw new ToySyntaxErrorException("Type error: operation \"/\" not defined for " + toErrString() + ", " + r.toErrString());
    }

    @Override
    public Value neg() {
        return new VBigInteger(v.negate());
    }

    @Override
    public Value lt(Value r) {
        if (r instanceof VLong) return new VBool(v.compareTo(BigInteger.valueOf(((VLong) r).v())) < 0);
        if (r instanceof VBigInteger) return new VBool(v.compareTo(((VBigInteger) r).v) < 0);

        throw new ToySyntaxErrorException("Type error: operation \"<\" not defined for " + toErrString() + ", " + r.toErrString());
    }

    @Override
    public Value le(Value r) {
        if (r instanceof VLong) return new VBool(v.compareTo(BigInteger.valueOf(((VLong) r).v())) <= 0);
        if (r instanceof VBigInteger) return new VBool(v.compareTo(((VBigInteger) r).v) <= 0);


        throw new ToySyntaxErrorException("Type error: operation \"<=\" not defined for " + toErrString() + ", " + r.toErrString());
    }

    @Override
    public Value eq(Value r) {
        if (r instanceof VLong) return new VBool(v.compareTo(BigInteger.valueOf(((VLong) r).v())) == 0);
        if (r instanceof VBigInteger) return new VBool(v.compareTo(((VBigInteger) r).v) == 0);

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
        return "Number " + v;
    }
}
