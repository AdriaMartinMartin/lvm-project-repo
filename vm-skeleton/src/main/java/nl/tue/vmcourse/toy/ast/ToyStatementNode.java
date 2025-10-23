package nl.tue.vmcourse.toy.ast;

import java.util.List;
import nl.tue.vmcourse.toy.bci.CompileContext;

public abstract class ToyStatementNode extends ToyAstNode {

    @Override
    public List<ToyAstNode> getChildren() {
        throw new RuntimeException("TODO: return children if any (or empty list otherwise)");
    }

    public abstract void compile(CompileContext ctx);
}
