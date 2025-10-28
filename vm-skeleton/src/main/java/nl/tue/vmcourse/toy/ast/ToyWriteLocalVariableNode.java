package nl.tue.vmcourse.toy.ast;

import nl.tue.vmcourse.toy.bci.CompileContext;
import nl.tue.vmcourse.toy.bci.OpCode;

import java.util.Objects;

public class ToyWriteLocalVariableNode extends ToyExpressionNode {
    private final ToyExpressionNode valueNode;
    private final Integer frameSlot;
    private final ToyExpressionNode nameNode;
    private final boolean newVariable;

    public ToyWriteLocalVariableNode(ToyExpressionNode valueNode, Integer frameSlot, ToyExpressionNode nameNode, boolean newVariable) {
        super();
        this.valueNode = valueNode;
        this.frameSlot = Objects.requireNonNull(frameSlot);
        this.nameNode = nameNode;
        this.newVariable = newVariable;
    }

    @Override
    public void compile(CompileContext ctx) {
        // nameNode.compile(ctx); // TODO: Re-think if it's needed that the local slots should be name-accessible
        if (valueNode != null)
            valueNode.compile(ctx);
        else
            ctx.emit(OpCode.PUSH_NULL);
        ctx.emit(OpCode.STR_K);
        ctx.emitU16(frameSlot.shortValue());
    }

    @Override
    public String toString() {
        return "ToyWriteLocalVariableNode{" +
                "valueNode=" + valueNode +
                ", frameSlot=" + frameSlot +
                ", nameNode=" + nameNode +
                ", newVariable=" + newVariable +
                '}';
    }
}
