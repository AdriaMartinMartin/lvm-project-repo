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

        final int startAddr = ctx.position();

        conditionNode.compile(ctx);

        ctx.emit(OpCode.JNE);
        final int patchJne = ctx.position();
        ctx.emitI32(0);

        bodyNode.compile(ctx);
        ctx.emit(OpCode.JMP);
        ctx.emitI32(startAddr);

        ctx.patchI32(patchJne, ctx.position());
    }

    @Override
    public String toString() {
        return "ToyWhileNode{" +
                "conditionNode=" + conditionNode +
                ", bodyNode=" + bodyNode +
                '}';
    }
}
