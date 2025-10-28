package nl.tue.vmcourse.toy.ast;

import nl.tue.vmcourse.toy.bci.CompileContext;
import nl.tue.vmcourse.toy.bci.OpCode;
import nl.tue.vmcourse.toy.interpreter.ToyAbstractFunctionBody;
import nl.tue.vmcourse.toy.lang.RootCallTarget;
import nl.tue.vmcourse.toy.lang.VirtualFrame;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ToyFunctionBodyNode extends ToyStatementNode {
    private final ToyStatementNode methodBlock;

    public ToyFunctionBodyNode(ToyStatementNode methodBlock) {
        this.methodBlock = methodBlock;
    }

    @Override
    public void compile(CompileContext ctx) {
        methodBlock.compile(ctx);

        ctx.emit(OpCode.PUSH_NULL);
        ctx.emit(OpCode.RET);
    }

    public String printTree(String functionName) {
        return "ToyFunctionBodyNode{" +
            "functionName=" + functionName +
            ", methodBlock=" + methodBlock +
            '}';
    }
}
