package nl.tue.vmcourse.toy.ast;

import nl.tue.vmcourse.toy.bci.CompileContext;
import nl.tue.vmcourse.toy.bci.OpCode;

import java.util.List;

public class ToyStatementExpressionNode extends ToyExpressionNode{
        private final ToyStatementNode expr;

        public ToyStatementExpressionNode(ToyStatementNode expr) {
            this.expr = expr;
        }

        public ToyStatementNode getExpr() {
            return expr;
        }

        @Override
        public List<ToyAstNode> getChildren() {
            return super.getChildren();
        }

        @Override
        public void compile(CompileContext ctx) {
            expr.compile(ctx);
            ctx.emit(OpCode.POP);
        }

    @Override
    public String toString() {
        return "ToyStatementExpressionNode{" +
            "expr=" + expr +
            '}';
    }
}
