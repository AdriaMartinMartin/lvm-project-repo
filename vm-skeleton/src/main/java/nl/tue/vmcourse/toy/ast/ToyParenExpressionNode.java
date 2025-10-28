package nl.tue.vmcourse.toy.ast;

import nl.tue.vmcourse.toy.bci.CompileContext;

public class ToyParenExpressionNode extends ToyExpressionNode {
    private final ToyExpressionNode expressionNode;

    public ToyParenExpressionNode(ToyExpressionNode expressionNode) {
        this.expressionNode = expressionNode;
    }

    @Override
    public void compile(CompileContext ctx) {
        if (expressionNode != null) expressionNode.compile(ctx);
    }

    @Override
    public String toString() {
        return "ToyParenExpressionNode{" +
                "expressionNode=" + expressionNode +
                '}';
    }
}
