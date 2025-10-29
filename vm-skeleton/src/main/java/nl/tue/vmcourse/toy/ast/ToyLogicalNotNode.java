package nl.tue.vmcourse.toy.ast;

import nl.tue.vmcourse.toy.bci.CompileContext;
import nl.tue.vmcourse.toy.bci.OpCode;

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
        assert toyLessOrEqualNode != null;

        toyLessOrEqualNode.compile(ctx);
        ctx.emit(OpCode.NOT);
    }

    @Override
    public String toString() {
        return "ToyLogicalNotNode{" +
                "toyLessOrEqualNode=" + toyLessOrEqualNode +
                '}';
    }
}
