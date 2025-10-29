package nl.tue.vmcourse.toy.bci.value;

import nl.tue.vmcourse.toy.lang.RootCallTarget;

import java.util.Objects;

public class VFunction implements Value {
    private final RootCallTarget rt;
    private final String name;

    public VFunction(RootCallTarget rt, String name) {
        this.rt = rt;
        this.name = name;
    }

    public final RootCallTarget v() { return rt; }
    public final String getName() { return name; }

    @Override
    public Value add(Value r) { throw new RuntimeException("Functions cannot do addition operations!"); }

    @Override
    public Value sub(Value r) { throw new RuntimeException("Functions cannot do subtraction operations!"); }

    @Override
    public Value mul(Value r) { throw new RuntimeException("Functions cannot do multiplication operations!"); }

    @Override
    public Value div(Value r) { throw new RuntimeException("Functions cannot do divisions operations!"); }

    @Override
    public Value neg() { throw new RuntimeException("Functions cannot do unary operations!"); }

    @Override
    public Value lt(Value r) { throw new RuntimeException("Functions cannot do less than operations!"); }

    @Override
    public Value le(Value r) { throw new RuntimeException("Functions cannot do less equal operations!"); }

    @Override
    public Value eq(Value r) {
        if (r instanceof VFunction) return new VBool(Objects.equals(name, ((VFunction) r).getName()));

        return new VBool(false);
    }

    @Override
    public void print() {
        System.out.println(name);
    }

    @Override
    public String toString() {
        return "[function : " + name + "]";
    }
}
