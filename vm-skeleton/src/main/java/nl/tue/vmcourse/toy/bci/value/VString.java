package nl.tue.vmcourse.toy.bci.value;

public final class VString implements Value {
    private final String v;

    public VString(String v) {
        this.v = v;
    }

    public String v() { return v; }

    @Override
    public Value add(Value r) {
        if (r instanceof VString) {
            return new VString(v + ((VString) r).v());
        } else if (r instanceof VLong) {
            return new VString(v + ((VLong) r).v());
        }

        throw new UnsupportedOperationException("Cannot add VLong to " + r.getClass().getSimpleName());
    }

    @Override
    public void print() {
        System.out.println(v);
    }
}
