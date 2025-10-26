package nl.tue.vmcourse.toy.bci;

import com.ibm.icu.impl.Pair;
import nl.tue.vmcourse.toy.ast.ToyStatementNode;
import nl.tue.vmcourse.toy.bci.value.Value;
import nl.tue.vmcourse.toy.interpreter.ToyAbstractFunctionBody;
import nl.tue.vmcourse.toy.lang.RootCallTarget;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class AstToBciAssembler {

    public static ToyAbstractFunctionBody build(ToyStatementNode methodBlock) {
        CompileContext ctx = compileAst(methodBlock);

        byte[] code = ctx.toBytecode();
        List<Object> pool = ctx.getConstantPool();

        // TODO code is one argument; depending in impl other arguments might be needed (e.g., constant pool?)
        return new ToyBciLoop(code, pool);
    }

    private static CompileContext compileAst(ToyStatementNode methodBlock) {
        // TODO should explore AST and produce BC instructions.
        CompileContext ctx =  new CompileContext();
        methodBlock.compile(ctx);
        return ctx;
    }
}
