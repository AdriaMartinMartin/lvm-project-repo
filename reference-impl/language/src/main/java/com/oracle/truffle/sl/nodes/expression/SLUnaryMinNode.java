package com.oracle.truffle.sl.nodes.expression;

import java.math.BigInteger;

import com.oracle.truffle.api.frame.VirtualFrame;
import com.oracle.truffle.api.nodes.NodeInfo;
import com.oracle.truffle.api.nodes.UnexpectedResultException;
import com.oracle.truffle.sl.nodes.SLExpressionNode;
import com.oracle.truffle.sl.SLException;

/**
 * A {@link SLExpressionNode} that represents a parenthesized expression; it simply returns the
 * value of the enclosed (child) expression. It is represented separately in the AST for the purpose
 * of correct source attribution; this preserves the lexical relationship between the two
 * parentheses and allows a tool to describe the expression as distinct from its contents.
 */
@NodeInfo(shortName = "-")
public class SLUnaryMinNode extends SLExpressionNode {

    @Child private SLExpressionNode expression;

    public SLUnaryMinNode(SLExpressionNode expression) {
        this.expression = expression;
    }

    @Override
    public Object executeGeneric(VirtualFrame frame) {
      Object result = expression.executeGeneric(frame);
      if (result instanceof Long)
        return -(Long)result;
      else if (result instanceof BigInteger)
        return ((BigInteger)result).negate();

      throw SLException.runtimeError(this, "Unary operation only defined for numbers");
    }
}
