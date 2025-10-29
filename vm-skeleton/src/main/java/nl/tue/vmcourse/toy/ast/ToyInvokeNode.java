package nl.tue.vmcourse.toy.ast;

import nl.tue.vmcourse.toy.bci.CompileContext;
import nl.tue.vmcourse.toy.bci.OpCode;

import java.util.Arrays;
import java.util.Objects;

public class ToyInvokeNode extends ToyExpressionNode {
    private final ToyExpressionNode functionNode;
    private final ToyExpressionNode[] toyExpressionNodes;

    public ToyInvokeNode(ToyExpressionNode functionNode, ToyExpressionNode[] toyExpressionNodes) {
        super();
        this.functionNode = Objects.requireNonNull(functionNode);
        this.toyExpressionNodes = toyExpressionNodes;
    }

    @Override
    public String toString() {
        return "ToyInvokeNode{" +
            "functionNode=" + functionNode +
            ", toyExpressionNodes=" + Arrays.toString(toyExpressionNodes) +
            '}';
    }

    @Override
    public void compile(CompileContext ctx) {
        if (functionNode != null)
            for (ToyExpressionNode node : toyExpressionNodes) {
                node.compile(ctx);
            }

        functionNode.compile(ctx);
        ctx.emit(OpCode.CALL);
        ctx.emitU16((short) toyExpressionNodes.length);
    }
}
