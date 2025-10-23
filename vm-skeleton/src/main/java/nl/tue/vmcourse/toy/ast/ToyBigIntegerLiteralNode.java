package nl.tue.vmcourse.toy.ast;

import nl.tue.vmcourse.toy.bci.CompileContext;

import java.math.BigInteger;

public class ToyBigIntegerLiteralNode extends ToyExpressionNode {
    private final BigInteger bigInteger;

    public ToyBigIntegerLiteralNode(BigInteger bigInteger) {
        super();
        this.bigInteger = bigInteger;
    }

    @Override
    public String toString() {
        return "ToyBigIntegerLiteralNode{" +
                "bigInteger=" + bigInteger +
                '}';
    }

    @Override
    public void compile(CompileContext ctx) {

    }
}
