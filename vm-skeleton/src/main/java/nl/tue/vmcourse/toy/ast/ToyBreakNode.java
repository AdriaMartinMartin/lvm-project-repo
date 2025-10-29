package nl.tue.vmcourse.toy.ast;

import nl.tue.vmcourse.toy.bci.CompileContext;

public class ToyBreakNode extends ToyStatementNode {

    @Override
    public String toString() {
        return "break";
    }

    @Override
    public void compile(CompileContext ctx) {
        ctx.emitJMPto(ctx.currBTarget());
    }
}
