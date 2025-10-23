package nl.tue.vmcourse.toy.ast;

import nl.tue.vmcourse.toy.bci.CompileContext;

public class ToyFunctionLiteralNode extends ToyExpressionNode {
    private final String name;

    public ToyFunctionLiteralNode(String name) {
        super();
        this.name = name;
    }

    @Override
    public String toString() {
        return "ToyFunctionLiteralNode{" +
                "name='" + name + '\'' +
                '}';
    }

    @Override
    public void compile(CompileContext ctx) {


    }
}
