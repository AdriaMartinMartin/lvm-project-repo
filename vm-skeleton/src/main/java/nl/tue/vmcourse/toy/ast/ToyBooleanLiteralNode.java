package nl.tue.vmcourse.toy.ast;

import nl.tue.vmcourse.toy.bci.CompileContext;

public class ToyBooleanLiteralNode extends ToyExpressionNode {
    private final boolean value;

    public ToyBooleanLiteralNode(boolean value) {
        this.value = value;
    }

    @Override
    public String toString() {
        return "ToyBooleanLiteralNode{" +
                "value=" + value +
                '}';
    }

    @Override
    public void compile(CompileContext ctx) {

    }
}
