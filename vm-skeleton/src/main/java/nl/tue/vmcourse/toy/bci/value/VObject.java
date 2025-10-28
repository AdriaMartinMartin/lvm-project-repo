package nl.tue.vmcourse.toy.bci.value;

import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Set;

public class VObject implements Value {
    private final Map<String, Value> props;

    public VObject() {
        this.props = new LinkedHashMap<>();
    }

    public final Map<String, Value> v() { return props; }

    public Value get(Value key) {
        return props.getOrDefault(toKeyString(key), Value.NULL);
    }

    public void set(Value key, Value v) {
        props.put(toKeyString(key), v);
    }

    public void set(String key, Value v) {
        props.put(key, v);
    }

    public Value has(Value key) {
        return new VBool(props.containsKey(toKeyString(key)));
    }

    public Boolean delete(Value key) {
        return props.remove(toKeyString(key)) != null;
    }

    public int size() {
        return props.size();
    }

    public Set<String> keys() {
        return Collections.unmodifiableSet(props.keySet());
    }

    public static String toKeyString(Value v) {
        if (v instanceof VObject) {
            throw new RuntimeException("Invalid property key type: " + v.getClass().getSimpleName());
        }

        return v.toString();
    }

    @Override
    public Value add(Value r) {
        if (r instanceof VString) return new VString(props + ((VString) r).v());
        throw new RuntimeException("Cannot perform addition between VObject and " + r.getClass().getSimpleName());
    }

    @Override
    public Value sub(Value r) { throw new RuntimeException("Cannot do subtraction with VObjects"); }

    @Override
    public Value mul(Value r) { throw new RuntimeException("Cannot do multiplications with VObjects"); }

    @Override
    public Value neg() { throw new RuntimeException("Cannot do unary operation with VObjects"); }

    @Override
    public Value lt(Value r) { throw new RuntimeException("Cannot do less than operations with VObjects"); }

    @Override
    public Value eq(Value r) {
        if (r instanceof VObject) {
            return new VBool(props == ((VObject) r).v());
        }

        return new VBool(false);
    }

    @Override
    public void print() {
        System.out.println(props);
    }

    @Override
    public String toString() {
        return "VObject{" +
            "props=" + props +
            '}';
    }
}
