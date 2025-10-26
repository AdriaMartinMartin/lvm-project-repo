package nl.tue.vmcourse.toy.ast;

import nl.tue.vmcourse.toy.bci.CompileContext;
import nl.tue.vmcourse.toy.bci.OpCode;

public class ToyReadArgumentNode extends ToyExpressionNode {
    private final Integer parameterCount;

    public ToyReadArgumentNode(int parameterCount) {
        this.parameterCount = parameterCount;
    }

    @Override
    public void compile(CompileContext ctx) {
        ctx.emit(OpCode.LOAD_ARG);
        ctx.emitU16(parameterCount.shortValue());
    }

    @Override
    public String toString() {
        return "ToyReadArgumentNode{" +
                "parameterCount=" + parameterCount +
                '}';
    }
}
