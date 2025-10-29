package nl.tue.vmcourse.toy.ast;

import nl.tue.vmcourse.toy.bci.CompileContext;
import nl.tue.vmcourse.toy.bci.OpCode;

public class ToyWhileNode extends ToyStatementNode {
    private final ToyExpressionNode conditionNode;
    private final ToyStatementNode bodyNode;

    public ToyWhileNode(ToyExpressionNode conditionNode, ToyStatementNode bodyNode) {
        this.conditionNode = conditionNode;
        this.bodyNode = bodyNode;
    }

    @Override
    public void compile(CompileContext ctx) {
        assert conditionNode != null && bodyNode != null;

        CompileContext.Label Lcond = ctx.newLabel();
        CompileContext.Label Lend = ctx.newLabel();

        ctx.enterLoop(Lend, Lcond);

        ctx.mark(Lcond);
        conditionNode.compile(ctx);
        ctx.emitJNEto(Lend);

        bodyNode.compile(ctx);

        ctx.emitJMPto(Lcond);
        ctx.mark(Lend);
        ctx.exitLoop();
    }

    @Override
    public String toString() {
        return "ToyWhileNode{" +
                "conditionNode=" + conditionNode +
                ", bodyNode=" + bodyNode +
                '}';
    }
}
