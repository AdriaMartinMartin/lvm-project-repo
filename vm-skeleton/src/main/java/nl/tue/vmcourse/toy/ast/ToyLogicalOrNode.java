package nl.tue.vmcourse.toy.ast;

import nl.tue.vmcourse.toy.bci.CompileContext;
import nl.tue.vmcourse.toy.bci.OpCode;

public class ToyLogicalOrNode extends ToyExpressionNode {
    private final ToyExpressionNode leftUnboxed;
    private final ToyExpressionNode rightUnboxed;

    public ToyLogicalOrNode(ToyExpressionNode leftUnboxed, ToyExpressionNode rightUnboxed) {
        super();
        this.leftUnboxed = leftUnboxed;
        this.rightUnboxed = rightUnboxed;
    }

    @Override
    public void compile(CompileContext ctx) {
        assert leftUnboxed != null;

        CompileContext.Label L_false = ctx.newLabel();
        CompileContext.Label L_end = ctx.newLabel();

        leftUnboxed.compile(ctx);
        ctx.emit(OpCode.OR_L);
        ctx.emitJNEto(L_false);

        ctx.emit(OpCode.PUSH_K);
        ctx.addConstant(true);
        ctx.emitJMPto(L_end);

        ctx.mark(L_false);
        rightUnboxed.compile(ctx);
        ctx.emit(OpCode.OR_R);

        ctx.mark(L_end);
    }

    @Override
    public String toString() {
        return "ToyLogicalOrNode{" +
                "leftUnboxed=" + leftUnboxed +
                ", rightUnboxed=" + rightUnboxed +
                '}';
    }
}
