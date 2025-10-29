package nl.tue.vmcourse.toy.ast;

import nl.tue.vmcourse.toy.bci.CompileContext;
import nl.tue.vmcourse.toy.bci.OpCode;

public class ToyFunctionLiteralNode extends ToyExpressionNode {
    private final String name;

    public ToyFunctionLiteralNode(String name) {
        super();
        this.name = name;
    }

    public String getName() {
        return name;
    }

    @Override
    public String toString() {
        return "ToyFunctionLiteralNode{" +
            "name='" + name + '\'' +
            '}';
    }

    @Override
    public void compile(CompileContext ctx) {
        ctx.emit(OpCode.PUSH_F);
        ctx.addConstant(name);
    }
}
