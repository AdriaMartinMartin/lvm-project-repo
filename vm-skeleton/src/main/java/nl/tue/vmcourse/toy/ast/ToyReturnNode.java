package nl.tue.vmcourse.toy.ast;

import nl.tue.vmcourse.toy.bci.CompileContext;
import nl.tue.vmcourse.toy.bci.OpCode;

public class ToyReturnNode extends ToyStatementNode {
    private final ToyExpressionNode valueNode;

    public ToyReturnNode(ToyExpressionNode valueNode) {
        this.valueNode = valueNode;
    }

    @Override
    public void compile(CompileContext ctx) {
        if (valueNode != null) {
            valueNode.compile(ctx);
        } else {
            ctx.emit(OpCode.PUSH_NULL);
        }
        ctx.emit(OpCode.RET);
    }

    @Override
    public String toString() {
        return "ToyReturnNode{" +
            "valueNode=" + valueNode +
            '}';
    }
}
