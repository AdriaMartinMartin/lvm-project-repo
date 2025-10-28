package nl.tue.vmcourse.toy.ast;

import nl.tue.vmcourse.toy.bci.CompileContext;
import nl.tue.vmcourse.toy.bci.OpCode;

public class ToyLongLiteralNode extends ToyExpressionNode {
    private final long value;

    public ToyLongLiteralNode(long value) {
        super();
        this.value = value;
    }

    @Override
    public String toString() {
        return "ToyLongLiteralNode{" +
                "value=" + value +
                '}';
    }

    @Override
    public void compile(CompileContext ctx) {
        ctx.emit(OpCode.PUSH_I64);
        ctx.emitI64(value);
    }
}
