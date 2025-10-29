package nl.tue.vmcourse.toy.bci.value;

import java.math.BigInteger;

public final class VLong implements Value {
    private final long v;

    public VLong(long v) {
        this.v = v;
    }

    public long v() { return v; }

    @Override
    public Value add(Value r) {
        if (r instanceof VLong) {
            return new VLong(v + ((VLong) r).v());
        } else if (r instanceof VBigInteger) {
            return new VBigInteger(BigInteger.valueOf(v).add(((VBigInteger) r).v()));
        } else if (r instanceof VString) {
            return new VString(v + ((VString) r).v());
        }

        throw new UnsupportedOperationException("Cannot add VLong to " + r.getClass().getSimpleName());
    }

    @Override
    public Value sub(Value r) {
        if (r instanceof VLong) {
            return new VLong(v - ((VLong) r).v());
        } else if (r instanceof VBigInteger) {
            return new VBigInteger(BigInteger.valueOf(v).subtract(((VBigInteger) r).v()));
        }

        throw new RuntimeException("Type error: operation \"-\" not defined for VLong " + v +  ", " + r.getClass().getSimpleName() + r);
    }

    @Override
    public Value mul(Value r) {
        if (r instanceof VLong) return new VLong(v * ((VLong) r).v());
        else if (r instanceof VBigInteger) return new VBigInteger(BigInteger.valueOf(v).multiply(((VBigInteger) r).v()));
        throw new RuntimeException("Cannot multiply VLong to " + r.getClass().getSimpleName());
    }


    @Override
    public Value div(Value r) {
        if (r instanceof VLong) return new VLong(v / ((VLong) r).v());
        else if (r instanceof VBigInteger) return new VBigInteger(BigInteger.valueOf(v).divide(((VBigInteger) r).v()));
        throw new RuntimeException("Cannot multiply VLong to " + r.getClass().getSimpleName());
    }

    @Override
    public Value neg() {
        return new VLong(-v);
    }

    @Override
    public Value lt(Value r) {
        if (r instanceof VLong) return new VBool(v < ((VLong) r).v());
        else if (r instanceof VBigInteger) return new VBool(BigInteger.valueOf(v).compareTo(((VBigInteger) r).v()) < 0);
        throw new RuntimeException("Cannot do less than operation between VLong and " + r.getClass().getSimpleName());
    }

    @Override
    public Value le(Value r) {
        if (r instanceof VLong) return new VBool(v <= ((VLong) r).v());
        else if (r instanceof VBigInteger) return new VBool(BigInteger.valueOf(v).compareTo(((VBigInteger) r).v()) <= 0);
        throw new RuntimeException("Cannot do less than operation between VLong and " + r.getClass().getSimpleName());
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
    public void print() {
        System.out.println(v);
    }

    @Override
    public String toString() {
        return String.valueOf(v);
    }
}
