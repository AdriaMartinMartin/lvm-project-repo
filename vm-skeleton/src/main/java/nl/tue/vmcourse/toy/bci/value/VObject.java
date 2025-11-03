package nl.tue.vmcourse.toy.bci.value;

import nl.tue.vmcourse.toy.interpreter.ToySyntaxErrorException;

import java.util.Arrays;

public class VObject implements Value {
    private Shape shape = Shape.EMPTY_SHAPE;
    private Value[] fields = new Value[0];
    // public VObject prototype;

    public Shape shape() { return  shape; }


    public Value get(String key) {
        Integer slot = shape.slotOf(key);
        if (slot != null) return fields[slot];

        throw new ToySyntaxErrorException("Undefined property: " + key);
    }

    public Value getFast(int slot) { return fields[slot]; }

    public void set(String key, Value v) {
        Integer slot = shape.slotOf(key);
        if (slot == null) {
            shape = shape.addProperty(key);
            slot = shape.slotOf(key);
            ensureCapacity(slot);
        }

        fields[slot] = v;
    }

    public void setFast(int slot, Value v) { fields[slot] = v; }

    public boolean delete(Value k) {
        String key = toKeyString(k);

        if (shape.slotOf(key) == null) return false;

        this.shape = shape.deleteProperty(key);
        return true;
    }

    public Boolean has(Value v) {
        String key = toKeyString(v);
        return shape.slotOf(key) != null;
    }

    private void ensureCapacity(Integer slot) {
        if (slot >= fields.length) {
            fields = Arrays.copyOf(fields, slot + 1);
        }
    }

    public static String toKeyString(Value v) {
        if (v instanceof VBigInteger) return String.valueOf(((VBigInteger) v).v());
        if (v instanceof VBool) return String.valueOf(((VBool) v).v());
        if (v instanceof VFunction) return ((VFunction) v).getName();
        if (v instanceof VLong) return String.valueOf(((VLong) v).v());
        if (v instanceof VNull) return "NULL";
        if (v instanceof VObject) return "[foreign object]";
        if (v instanceof VType) return ((VType) v).v();
        if (v instanceof VString) return ((VString) v).v();

        throw new ToySyntaxErrorException("No valid key for Object");
    }

    @Override
    public Value add(Value r) {
        if (r instanceof VString) return new VString("[foreign object]" + ((VString) r).v());
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
        if (r instanceof VObject) {
            return new VBool(this == r);
        }

        return new VBool(false);
    }

    @Override
    public int length() {
        return shape.propToSlot.size();
    }

    @Override
    public void print() {
        System.out.println("Object");
    }

    @Override
    public String toString() {
        return "Object";
    }

    @Override
    public String toErrString() {
        return "Object Object";
    }
}
