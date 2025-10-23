package nl.tue.vmcourse.toy.ast;

import nl.tue.vmcourse.toy.bci.CompileContext;

public class ToyLogicalNotNode extends ToyExpressionNode {
    private final ToyExpressionNode toyLessOrEqualNode;

    public ToyLogicalNotNode(ToyLessOrEqualNode toyLessOrEqualNode) {
        super();
        this.toyLessOrEqualNode = toyLessOrEqualNode;
    }

    public ToyLogicalNotNode(ToyExpressionNode toyLessThanNode) {
        this.toyLessOrEqualNode = toyLessThanNode;
    }

    @Override
    public void compile(CompileContext ctx) {

    }

    @Override
    public String toString() {
        return "ToyLogicalNotNode{" +
                "toyLessOrEqualNode=" + toyLessOrEqualNode +
                '}';
    }
}
