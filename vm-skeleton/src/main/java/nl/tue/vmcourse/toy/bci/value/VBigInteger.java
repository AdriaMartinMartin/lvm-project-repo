package nl.tue.vmcourse.toy.bci.value;

import java.math.BigInteger;

public class VBigInteger implements Value {
    private final BigInteger v;

    public VBigInteger(BigInteger v) {
        this.v = v;
    }

    public final BigInteger v() { return v; }

    @Override
    public Value add(Value r) {
        if (r instanceof VString) return new VString(v + ((VString) r).v());
        if (r instanceof VLong) return new VBigInteger(v.add(BigInteger.valueOf(((VLong) r).v())));
        if (r instanceof VBigInteger) return new VBigInteger(v.add(((VBigInteger) r).v()));

        throw new RuntimeException("Cannot perform an addition between VBigInteger and " + r.getClass().getSimpleName());
    }

    @Override
    public Value sub(Value r) {
        if (r instanceof VLong) return new VBigInteger(v.subtract(BigInteger.valueOf(((VLong) r).v())));
        if (r instanceof VBigInteger) return new VBigInteger(v.subtract(((VBigInteger) r).v));

        throw new RuntimeException("Cannot perform a subtraction between VBigInteger and " + r.getClass().getSimpleName());
    }

    @Override
    public Value mul(Value r) {
        if (r instanceof VLong) return new VBigInteger(v.multiply(BigInteger.valueOf(((VLong) r).v())));
        if (r instanceof VBigInteger) return new VBigInteger(v.multiply(((VBigInteger) r).v));

        throw new RuntimeException("Cannot perform a multiplication between VBigInteger and " + r.getClass().getSimpleName());
    }

    @Override
    public Value div(Value r) {
        if (r instanceof VLong) return new VBigInteger(v.divide(BigInteger.valueOf(((VLong) r).v())));
        if (r instanceof VBigInteger) return new VBigInteger(v.divide(((VBigInteger) r).v));

        throw new RuntimeException("Cannot perform a multiplication between VBigInteger and " + r.getClass().getSimpleName());
    }

    @Override
    public Value neg() {
        return new VBigInteger(v.negate());
    }

    @Override
    public Value lt(Value r) {
        if (r instanceof VLong) return new VBool(v.compareTo(BigInteger.valueOf(((VLong) r).v())) < 0);
        if (r instanceof VBigInteger) return new VBool(v.compareTo(((VBigInteger) r).v) < 0);

        throw new RuntimeException("Cannot perform a less than operation between VBigInteger and " + r.getClass().getSimpleName());
    }

    @Override
    public Value le(Value r) {
        if (r instanceof VLong) return new VBool(v.compareTo(BigInteger.valueOf(((VLong) r).v())) <= 0);
        if (r instanceof VBigInteger) return new VBool(v.compareTo(((VBigInteger) r).v) <= 0);


        throw new RuntimeException("Cannot perform a less equal operation between VBigInteger and " + r.getClass().getSimpleName());
    }

    @Override
    public Value eq(Value r) {
        if (r instanceof VLong) return new VBool(v.compareTo(BigInteger.valueOf(((VLong) r).v())) == 0);
        if (r instanceof VBigInteger) return new VBool(v.compareTo(((VBigInteger) r).v) == 0);

        throw new RuntimeException("Cannot perform a equal than operation between VBigInteger and " + r.getClass().getSimpleName());
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
