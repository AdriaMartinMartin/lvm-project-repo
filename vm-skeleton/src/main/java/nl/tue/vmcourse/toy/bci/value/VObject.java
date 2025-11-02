package nl.tue.vmcourse.toy.bci.value;

import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Set;

import nl.tue.vmcourse.toy.interpreter.ToySyntaxErrorException;

public class VObject implements Value {
    private final Map<String, Value> props;

    public VObject() {
        this.props = new LinkedHashMap<>();
    }

    public final Map<String, Value> v() {
        return props;
    }

    public Value get(Value key) {
        Value v = props.get(toKeyString(key));

        if (v == null) throw new ToySyntaxErrorException("Undefined property: " + key.toString());

        return v;
    }

    public Value get(long idx) {
        return props.values().stream().skip(idx).findFirst().orElse(Value.NULL);
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
            return ((VObject) v).v().toString();
        }

        return v.toString();
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
            return new VBool(props == ((VObject) r).v());
        }

        return new VBool(false);
    }

    @Override
    public int length() {
        return props.size();
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
