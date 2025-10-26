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
        for (ToyStatementNode node : statements) {
            node.compile(ctx);
        }

        ctx.emit(OpCode.PUSH_NULL);
        ctx.emit(OpCode.RET);
    }

    public Iterable<? extends ToyStatementNode> getStatements() {
        return List.of(statements);
    }

    public String printTree(String functionName) {
        return "ToyBlockNode{" +
                "functionName=" + functionName +
                ", statements=" + Arrays.toString(statements) +
                '}';
    }
}
