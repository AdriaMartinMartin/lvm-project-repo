package nl.tue.vmcourse.toy.ast;

import nl.tue.vmcourse.toy.bci.CompileContext;
import nl.tue.vmcourse.toy.bci.OpCode;

import java.util.Arrays;
import java.util.List;

public class ToyBlockNode extends ToyStatementNode {
    private final ToyStatementNode[] statements;

    public ToyBlockNode(ToyStatementNode[] nodes) {
        super();
        this.statements = nodes;
    }

    @Override
    public void compile(CompileContext ctx) {
        if (statements != null)
            for (ToyStatementNode node : statements) {
                node.compile(ctx);
            }
    }

    public Iterable<? extends ToyStatementNode> getStatements() {
        return List.of(statements);
    }

    @Override
    public String toString() {
        return "ToyBlockNode{" +
            "statements=" + Arrays.toString(statements) +
            '}';
    }
}
