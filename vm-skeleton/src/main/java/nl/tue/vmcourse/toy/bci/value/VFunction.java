package nl.tue.vmcourse.toy.bci.value;

import nl.tue.vmcourse.toy.interpreter.ToySyntaxErrorException;
import nl.tue.vmcourse.toy.lang.RootCallTarget;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

public class VFunction implements Value {
    private static final Map<String, VFunction> funcByName = new HashMap<>();
    private RootCallTarget rt;
    private final String name;

    public static VFunction getFunction(String name, RootCallTarget rt) {
        return funcByName.computeIfAbsent(name, n -> new VFunction(rt, n));
    }

    private VFunction(RootCallTarget rt, String name) {
        this.rt = rt;
        this.name = name;
    }

    public static void redefine(String name, RootCallTarget newRt) {
        funcByName.computeIfAbsent(name, n -> new VFunction(newRt, n)).setTarget(newRt);
    }

    public final RootCallTarget v() {
        return rt;
    }

    public void setTarget(RootCallTarget rt) { this.rt = rt; }

    public final String getName() {
        return name;
    }

    @Override
    public Value add(Value r) {
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
        if (r instanceof VFunction) return new VBool(Objects.equals(name, ((VFunction) r).getName()));

        return new VBool(false);
    }

    @Override
    public int length() {
        throw new ToySyntaxErrorException("Element is not a valid array.");
    }

    @Override
    public void print() {
        if (rt == null) throw new ToySyntaxErrorException("Unknown object: \"" + name + "\"");

        System.out.println(name);
    }

    @Override
    public String toString() {
        return "[function : " + name + "]";
    }

    @Override
    public String toErrString() {
        return "Function " + name;
    }
}
