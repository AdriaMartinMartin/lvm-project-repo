package nl.tue.vmcourse.toy.ast;

import nl.tue.vmcourse.toy.bci.CompileContext;
import nl.tue.vmcourse.toy.bci.OpCode;

public class ToyEqualNode extends ToyExpressionNode {
    private final ToyExpressionNode leftUnboxed;
    private final ToyExpressionNode rightUnboxed;

    public ToyEqualNode(ToyExpressionNode leftUnboxed, ToyExpressionNode rightUnboxed) {
        super();
        this.leftUnboxed = leftUnboxed;
        this.rightUnboxed = rightUnboxed;
    }

    @Override
    public void compile(CompileContext ctx) {
        if (leftUnboxed == null) ctx.emit(OpCode.PUSH_NULL);
        else leftUnboxed.compile(ctx);

        if (rightUnboxed == null) ctx.emit(OpCode.PUSH_NULL);
        else rightUnboxed.compile(ctx);

        ctx.emit(OpCode.EQ);
    }

    @Override
    public String toString() {
        return "ToyEqualNode{" +
                "leftUnboxed=" + leftUnboxed +
                ", rightUnboxed=" + rightUnboxed +
                '}';
    }
}
