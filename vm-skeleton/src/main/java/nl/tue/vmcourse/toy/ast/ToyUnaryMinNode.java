package nl.tue.vmcourse.toy.ast;

import nl.tue.vmcourse.toy.bci.CompileContext;
import nl.tue.vmcourse.toy.bci.OpCode;

import java.util.Objects;

public class ToyUnaryMinNode extends ToyExpressionNode {

    private final ToyExpressionNode exp;

    public ToyUnaryMinNode(ToyExpressionNode exp) {
        this.exp = Objects.requireNonNull(exp);
    }

    @Override
    public void compile(CompileContext ctx) {
        exp.compile(ctx);
        ctx.emit(OpCode.NEG);
    }

    @Override
    public String toString() {
        return "ToyUnaryMinNode{" +
                "exp=" + exp +
                '}';
    }
}
