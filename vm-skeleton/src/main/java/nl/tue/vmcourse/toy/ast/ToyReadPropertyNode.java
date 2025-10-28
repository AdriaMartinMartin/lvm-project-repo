package nl.tue.vmcourse.toy.ast;

import nl.tue.vmcourse.toy.bci.CompileContext;
import nl.tue.vmcourse.toy.bci.OpCode;

public class ToyReadPropertyNode extends ToyExpressionNode {
    private final ToyExpressionNode receiverNode;
    private final ToyExpressionNode nameNode;

    public ToyReadPropertyNode(ToyExpressionNode receiverNode, ToyExpressionNode nameNode) {
        super();
        this.receiverNode = receiverNode;
        this.nameNode = nameNode;
    }

    @Override
    public void compile(CompileContext ctx) {
        assert receiverNode != null && receiverNode instanceof ToyReadLocalVariableNode;

        receiverNode.compile(ctx);
        if (nameNode != null) nameNode.compile(ctx); else ctx.emit(OpCode.PUSH_NULL);
        ctx.emit(OpCode.GETPROP);
    }

    @Override
    public String toString() {
        return "ToyReadPropertyNode{" +
                "receiverNode=" + receiverNode +
                ", nameNode=" + nameNode +
                '}';
    }
}
