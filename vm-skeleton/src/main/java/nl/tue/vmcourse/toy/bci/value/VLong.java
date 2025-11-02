package nl.tue.vmcourse.toy.bci.value;

import java.math.BigInteger;
import nl.tue.vmcourse.toy.interpreter.ToySyntaxErrorException;

public final class VLong implements Value {
    private final long v;

    public VLong(long v) {
        this.v = v;
    }

    public long v() { return v; }

    @Override
    public Value add(Value r) {
        if (r instanceof VLong) {
            return new VBigInteger(BigInteger.valueOf(v).add(BigInteger.valueOf(((VLong) r).v())));
        } else if (r instanceof VBigInteger) {
            return new VBigInteger(BigInteger.valueOf(v).add(((VBigInteger) r).v()));
        } else if (r instanceof VString) {
            return new VString(v + ((VString) r).v());
        }

        throw new ToySyntaxErrorException("Type error: operation \"+\" not defined for " + toErrString() + ", " + r.toErrString());
    }

    @Override
    public Value sub(Value r) {
        if (r instanceof VLong) {
            return new VLong(v - ((VLong) r).v());
        } else if (r instanceof VBigInteger) {
            return new VBigInteger(BigInteger.valueOf(v).subtract(((VBigInteger) r).v()));
        }

        throw new ToySyntaxErrorException("Type error: operation \"-\" not defined for " + toErrString() + ", " + r.toErrString());
    }

    @Override
    public Value mul(Value r) {
        if (r instanceof VLong) return new VBigInteger(BigInteger.valueOf(v).multiply(BigInteger.valueOf(((VLong) r).v())));
        else if (r instanceof VBigInteger) return new VBigInteger(BigInteger.valueOf(v).multiply(((VBigInteger) r).v()));
        throw new ToySyntaxErrorException("Type error: operation \"*\" not defined for " + toErrString() + ", " + r.toErrString());
    }


    @Override
    public Value div(Value r) {
        if (r instanceof VLong) {
            if (((VLong) r).v() == 0)
                throw new ToySyntaxErrorException("Runtime error on \"/\": Division by zero");
            else
                return new VLong(v / ((VLong) r).v());
        }
        else if (r instanceof VBigInteger)
        {
            if (((VBigInteger) r).v().equals(0))
                throw new ToySyntaxErrorException("Runtime error on \"/\": Division by zero");
            else
                return new VBigInteger(BigInteger.valueOf(v).divide(((VBigInteger) r).v()));
        }

        throw new ToySyntaxErrorException("Type error: operation \"/\" not defined for " + toErrString() + ", " + r.toErrString());
    }

    @Override
    public Value neg() {
        return new VLong(-v);
    }

    @Override
    public Value lt(Value r) {
        if (r instanceof VLong) return new VBool(v < ((VLong) r).v());
        else if (r instanceof VBigInteger) return new VBool(BigInteger.valueOf(v).compareTo(((VBigInteger) r).v()) < 0);
        throw new ToySyntaxErrorException("Type error: operation \"<\" not defined for " + toErrString() + ", " + r.toErrString());
    }

    @Override
    public Value le(Value r) {
        if (r instanceof VLong) return new VBool(v <= ((VLong) r).v());
        else if (r instanceof VBigInteger) return new VBool(BigInteger.valueOf(v).compareTo(((VBigInteger) r).v()) <= 0);
        throw new ToySyntaxErrorException("Type error: operation \"<=\" not defined for " + toErrString() + ", " + r.toErrString());
    }

    @Override
    public Value eq(Value r) {
        if (r instanceof VLong)
            return new VBool(v == ((VLong) r).v());
        else if (r instanceof VBigInteger)
            return new VBool(BigInteger.valueOf(v).compareTo(((VBigInteger) r).v()) == 0);

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
    public String toErrString() { return "Number " + v; }
}
