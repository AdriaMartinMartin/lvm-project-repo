package nl.tue.vmcourse.toy.bci.value;

import nl.tue.vmcourse.toy.interpreter.ToySyntaxErrorException;

import java.util.Objects;

public class VType implements Value {
    private final String type;

    public VType(String type) {
        this.type = type;
    }

    public VType(Value v) {
        String type = "NULL";
        if (v instanceof VLong || v instanceof VBigInteger) type = "Number";
        else if (v instanceof VString) type = "String";
        else if (v instanceof VBool) type = "Boolean";
        else if (v instanceof VNull) type = "NULL";
        else if (v instanceof VObject) type = "Object";
        else if (v instanceof VFunction) type = "Function";
        else if (v instanceof VType) type = "Type";

        this.type = type;
    }

    public final String v() {
        return type;
    }

    @Override
    public Value add(Value r) {
        if (r instanceof VString)
            return new VString(type + r);
        
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
        throw new ToySyntaxErrorException("Runtime error on \"-\": Unary operation only defined for types");
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
        if (r instanceof VType)
            return new VBool(Objects.equals(type, ((VType) r).v()));

        return new VBool(false);
    }

    @Override
    public int length() {
        throw new ToySyntaxErrorException("Element is not a valid array.");
    }

    @Override
    public void print() {
        System.out.println(type);
    }

    @Override
    public String toString() {
        return type;
    }


    @Override
    public String toErrString() {
        return type;
    }
}
