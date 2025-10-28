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
        conditionNode.compile(ctx);

        ctx.emit(OpCode.JNE);
        final int jneAddrPos = ctx.position();
        ctx.emitI32(0);

        if (thenPartNode != null) thenPartNode.compile(ctx);

        if (elsePartNode != null) {
            ctx.emit(OpCode.JMP);
            final int jmpAddrPos = ctx.position();
            ctx.emitI32(0);

            final int elseBlockStart = ctx.position();
            ctx.patchI32(jneAddrPos, elseBlockStart);

            elsePartNode.compile(ctx);
            final int cont = ctx.position();
            ctx.patchI32(jmpAddrPos, cont);
        } else {
            final int cont = ctx.position();
            ctx.patchI32(jneAddrPos, cont);
        }
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
