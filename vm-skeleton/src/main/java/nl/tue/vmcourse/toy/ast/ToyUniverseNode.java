package nl.tue.vmcourse.toy.ast;

import nl.tue.vmcourse.toy.bci.CompileContext;

public class ToyUniverseNode extends ToyExpressionNode {

    @Override
    public void compile(CompileContext ctx) {

    }

    @Override
    public String toString() {
        return "universe";
    }
}
