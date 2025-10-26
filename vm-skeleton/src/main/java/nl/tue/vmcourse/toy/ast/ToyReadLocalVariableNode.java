package nl.tue.vmcourse.toy.ast;

import nl.tue.vmcourse.toy.bci.CompileContext;
import nl.tue.vmcourse.toy.bci.OpCode;

public class ToyReadLocalVariableNode extends ToyExpressionNode {
    private final Integer frameSlot;

    public ToyReadLocalVariableNode(Integer frameSlot) {
        super();
        this.frameSlot = frameSlot;
    }

    @Override
    public void compile(CompileContext ctx) {
        ctx.emit(OpCode.LOAD_L);
        ctx.emitU16(frameSlot.shortValue());
    }

    @Override
    public String toString() {
        return "ToyReadLocalVariableNode{" +
                "frameSlot=" + frameSlot +
                '}';
    }
}
