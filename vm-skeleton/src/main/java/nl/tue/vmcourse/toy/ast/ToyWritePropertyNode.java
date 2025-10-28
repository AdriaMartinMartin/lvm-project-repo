package nl.tue.vmcourse.toy.ast;

import nl.tue.vmcourse.toy.bci.CompileContext;
import nl.tue.vmcourse.toy.bci.OpCode;

public class ToyWritePropertyNode extends ToyExpressionNode {
    private final ToyExpressionNode receiverNode;
    private final ToyExpressionNode nameNode;
    private final ToyExpressionNode valueNode;

    public ToyWritePropertyNode(ToyExpressionNode receiverNode, ToyExpressionNode nameNode, ToyExpressionNode valueNode) {
        super();
        this.receiverNode = receiverNode;
        this.nameNode = nameNode;
        this.valueNode = valueNode;
    }

    @Override
    public void compile(CompileContext ctx) {
        if (receiverNode != null) {
            receiverNode.compile(ctx);
            if (nameNode != null) nameNode.compile(ctx); else ctx.emit(OpCode.PUSH_NULL);
            if (valueNode != null) valueNode.compile(ctx); else ctx.emit(OpCode.PUSH_NULL);
            ctx.emit(OpCode.SETPROP);
        }
    }

    @Override
    public String toString() {
        return "ToyWritePropertyNode{" +
                "receiverNode=" + receiverNode +
                ", nameNode=" + nameNode +
                ", valueNode=" + valueNode +
                '}';
    }
}
