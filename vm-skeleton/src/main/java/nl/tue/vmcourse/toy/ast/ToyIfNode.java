package nl.tue.vmcourse.toy.ast;

import nl.tue.vmcourse.toy.bci.CompileContext;
import nl.tue.vmcourse.toy.bci.OpCode;

import java.util.Objects;

public class ToyIfNode extends ToyStatementNode {
    private final ToyExpressionNode conditionNode;
    private final ToyStatementNode thenPartNode;
    private final ToyStatementNode elsePartNode;

    public ToyIfNode(ToyExpressionNode conditionNode, ToyStatementNode thenPartNode, ToyStatementNode elsePartNode) {
        this.conditionNode = Objects.requireNonNull(conditionNode);
        this.thenPartNode = thenPartNode;
        this.elsePartNode = elsePartNode;
    }

    @Override
    public void compile(CompileContext ctx) {
        CompileContext.Label Lelse = ctx.newLabel();
        CompileContext.Label Lend = ctx.newLabel();

        conditionNode.compile(ctx);

        if ((elsePartNode != null)) ctx.emitJNEto(Lelse);
        else ctx.emitJNEto(Lend);

        if (thenPartNode != null) thenPartNode.compile(ctx);

        if (elsePartNode != null) {
            ctx.emitJMPto(Lend);

            ctx.mark(Lelse);
            elsePartNode.compile(ctx);
        }

        ctx.mark(Lend);
    }

    @Override
    public String toString() {
        return "ToyIfNode{" +
            "conditionNode=" + conditionNode +
            ", thenPartNode=" + thenPartNode +
            ", elsePartNode=" + elsePartNode +
            '}';
    }
}
