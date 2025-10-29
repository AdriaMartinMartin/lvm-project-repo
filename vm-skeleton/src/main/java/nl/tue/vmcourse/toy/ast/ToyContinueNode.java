package nl.tue.vmcourse.toy.ast;

import nl.tue.vmcourse.toy.bci.CompileContext;

public class ToyContinueNode extends ToyStatementNode {
    @Override
    public void compile(CompileContext ctx) {
        ctx.emitJMPto(ctx.currCTarget());
    }

    @Override
    public String toString() {
        return "continue";
    }
}
