package nl.tue.vmcourse.toy.ast;

import nl.tue.vmcourse.toy.bci.CompileContext;
import nl.tue.vmcourse.toy.bci.OpCode;
import nl.tue.vmcourse.toy.bci.value.VString;

public class ToyStringLiteralNode extends ToyExpressionNode {

    private final String value;

    public ToyStringLiteralNode(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }

    @Override
    public void compile(CompileContext ctx) {
        ctx.emit(OpCode.PUSH_K);
        ctx.addConstant(value);
    }

    @Override
    public String toString() {
        return "ToyStringLiteralNode{" +
                "value='" + value + '\'' +
                '}';
    }
}
