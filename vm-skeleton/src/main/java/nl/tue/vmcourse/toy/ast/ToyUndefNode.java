package nl.tue.vmcourse.toy.ast;

import nl.tue.vmcourse.toy.bci.CompileContext;

public class ToyUndefNode extends ToyExpressionNode {

    public static final Object UNDEF = new Object();

    @Override
    public void compile(CompileContext ctx) {

    }

    @Override
    public String toString() {
        return "undef";
    }
}
