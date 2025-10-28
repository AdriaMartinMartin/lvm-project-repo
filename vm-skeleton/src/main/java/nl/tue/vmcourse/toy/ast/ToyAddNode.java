package nl.tue.vmcourse.toy.ast;

import nl.tue.vmcourse.toy.bci.CompileContext;
import nl.tue.vmcourse.toy.bci.OpCode;

import java.util.Objects;


public class ToyAddNode extends ToyExpressionNode {
    private final ToyExpressionNode leftUnboxed;
    private final ToyExpressionNode rightUnboxed;

    public ToyAddNode(ToyExpressionNode leftUnboxed, ToyExpressionNode rightUnboxed) {
        super();
        this.leftUnboxed = Objects.requireNonNull(leftUnboxed);
        this.rightUnboxed = Objects.requireNonNull(rightUnboxed);
    }

    @Override
    public void compile(CompileContext ctx) {
        leftUnboxed.compile(ctx);
        rightUnboxed.compile(ctx);
        ctx.emit(OpCode.ADD);
    }

    @Override
    public String toString() {
        return "ToyAddNode{" +
                "leftUnboxed=" + leftUnboxed +
                ", rightUnboxed=" + rightUnboxed +
                '}';
    }
}
