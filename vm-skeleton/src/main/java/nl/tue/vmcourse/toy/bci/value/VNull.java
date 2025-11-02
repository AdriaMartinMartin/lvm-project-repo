package nl.tue.vmcourse.toy.bci.value;

import nl.tue.vmcourse.toy.interpreter.ToySyntaxErrorException;

public class VNull implements Value {
    private static final VNull instance = new VNull();

    private VNull() {
    }

    ;

    public static VNull getInstance() {
        return instance;
    }

    public Object v() {
        return null;
    }

    @Override
    public Value add(Value r) {
        if (r instanceof VString) {
            return new VString("NULL" + r);
        }

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
        if (r instanceof VNull)
            return new VBool(true);

        return new VBool(false);
    }

    @Override
    public int length() {
        throw new ToySyntaxErrorException("Element is not a valid array.");
    }

    @Override
    public void print() {
        System.out.println("NULL");
    }

    @Override
    public String toString() {
        return "NULL";
    }


    @Override
    public String toErrString() {
        return "NULL";
    }
}
