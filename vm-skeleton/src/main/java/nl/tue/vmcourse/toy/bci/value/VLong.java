package nl.tue.vmcourse.toy.bci.value;

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
        } else if (r instanceof VString) {
            return new VString(v + ((VString) r).v());
        }

        throw new UnsupportedOperationException("Cannot add VLong to " + r.getClass().getSimpleName());
    }

    @Override
    public void print() {
        System.out.println(v);
    }
}
