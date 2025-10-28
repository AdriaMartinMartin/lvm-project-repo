package nl.tue.vmcourse.toy.bci.value;

import java.util.Objects;

public final class VString implements Value {
    private final String v;

    public VString(String v) {
        this.v = v;
    }

    public String v() { return v; }

    @Override
    public Value add(Value r) {
//        throw new UnsupportedOperationException("Cannot add VString to " + r.getClass().getSimpleName());
        return new VString(v + r);
    }

    @Override
    public Value sub(Value r) {
        throw new RuntimeException("Cannot do subtract operations with VString");
    }

    @Override
    public Value mul(Value r) {
        throw new RuntimeException("Cannot do multiplications with VString");
    }

    @Override
    public Value neg() {
        throw new RuntimeException("Error on \"-\": Unary operation only defined for numbers");
    }

    @Override
    public Value lt(Value r) { throw new RuntimeException("Cannot do less than operations with VString"); }

    @Override
    public Value eq(Value r) {
        if (r instanceof VString) {
            return new VBool(Objects.equals(v, ((VString) r).v()));
        }

        return new VBool(false);
    }

    @Override
    public void print() {
        System.out.println(v);
    }

    @Override
    public String toString() {
        return v;
    }
}
