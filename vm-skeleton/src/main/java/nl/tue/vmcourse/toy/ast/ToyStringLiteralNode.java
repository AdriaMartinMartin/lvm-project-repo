package nl.tue.vmcourse.toy.ast;

import nl.tue.vmcourse.toy.bci.CompileContext;

public class ToyStringLiteralNode extends ToyExpressionNode {

    private final String value;

    public ToyStringLiteralNode(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }

    @Override
    public void compile(CompileContext ctx) {

    }

    @Override
    public String toString() {
        return "ToyStringLiteralNode{" +
                "value='" + value + '\'' +
                '}';
    }
}
