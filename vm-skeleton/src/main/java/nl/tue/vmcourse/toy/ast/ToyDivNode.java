package nl.tue.vmcourse.toy.ast;

import nl.tue.vmcourse.toy.bci.CompileContext;
import nl.tue.vmcourse.toy.bci.OpCode;

public class ToyDivNode extends ToyExpressionNode {
    private final ToyExpressionNode leftUnboxed;
    private final ToyExpressionNode rightUnboxed;

    public ToyDivNode(ToyExpressionNode leftUnboxed, ToyExpressionNode rightUnboxed) {
        this.leftUnboxed = leftUnboxed;
        this.rightUnboxed = rightUnboxed;
    }

    @Override
    public void compile(CompileContext ctx) {
        leftUnboxed.compile(ctx);
        rightUnboxed.compile(ctx);
        ctx.emit(OpCode.DIV);
    }

    @Override
    public String toString() {
        return "ToyDivNode{" +
                "leftUnboxed=" + leftUnboxed +
                ", rightUnboxed=" + rightUnboxed +
                '}';
    }
}
