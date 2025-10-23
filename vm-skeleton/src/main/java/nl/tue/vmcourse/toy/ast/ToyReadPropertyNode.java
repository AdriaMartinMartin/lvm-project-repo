package nl.tue.vmcourse.toy.ast;

import nl.tue.vmcourse.toy.bci.CompileContext;

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

    }

    @Override
    public String toString() {
        return "ToyReadPropertyNode{" +
                "receiverNode=" + receiverNode +
                ", nameNode=" + nameNode +
                '}';
    }
}
