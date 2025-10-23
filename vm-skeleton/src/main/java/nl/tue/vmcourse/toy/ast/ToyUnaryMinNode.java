package nl.tue.vmcourse.toy.ast;

import nl.tue.vmcourse.toy.bci.CompileContext;

public class ToyUnaryMinNode extends ToyExpressionNode {

    private final ToyExpressionNode exp;

    public ToyUnaryMinNode(ToyExpressionNode exp) {
        this.exp = exp;
    }

    @Override
    public void compile(CompileContext ctx) {

    }

    @Override
    public String toString() {
        return "ToyUnaryMinNode{" +
                "exp=" + exp +
                '}';
    }
}
