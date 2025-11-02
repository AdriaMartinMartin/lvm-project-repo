package nl.tue.vmcourse.toy.builtins;

import nl.tue.vmcourse.toy.bci.BciTracer;
import nl.tue.vmcourse.toy.bci.OpCode;
import nl.tue.vmcourse.toy.bci.value.VFunction;
import nl.tue.vmcourse.toy.bci.value.VNull;
import nl.tue.vmcourse.toy.bci.value.VString;
import nl.tue.vmcourse.toy.bci.value.Value;
import nl.tue.vmcourse.toy.interpreter.ToyAbstractFunctionBody;
import nl.tue.vmcourse.toy.interpreter.ToyNodeFactory;
import nl.tue.vmcourse.toy.interpreter.ToySyntaxErrorException;
import nl.tue.vmcourse.toy.lang.RootCallTarget;
import nl.tue.vmcourse.toy.lang.VirtualFrame;
import nl.tue.vmcourse.toy.parser.ToyLangLexer;
import nl.tue.vmcourse.toy.parser.ToyLangParser;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;

import java.util.List;
import java.util.Map;

public class DefineFunctionBuiltin extends ToyAbstractFunctionBody {

    private final Map<String, RootCallTarget> functionTable;

    public DefineFunctionBuiltin(Map<String, RootCallTarget> functionTable) {
        this.functionTable = functionTable;
    }

    @Override
    public Object execute(VirtualFrame frame) {
        if (!(frame.get(0) instanceof VString)) throw new ToySyntaxErrorException("Type error: operation \"defineFunction\" not defined for " + ((Value) frame.get(0)).toErrString());

        String src = ((VString) frame.get(0)).v();

        ToyLangLexer lex = new ToyLangLexer(CharStreams.fromString(src));
        CommonTokenStream tokens = new CommonTokenStream(lex);
        ToyLangParser parser = new ToyLangParser(tokens);

        ToyNodeFactory factory = new ToyNodeFactory(src);
        parser.setFactory(factory);

        lex.removeErrorListeners();
        parser.removeErrorListeners();
        lex.addErrorListener(new ToyLangParser.BailoutErrorListener());
        parser.addErrorListener(new ToyLangParser.BailoutErrorListener());

        parser.toylanguage();

        Map<String, RootCallTarget> newFunc = factory.getAllFunctions();
        if (newFunc.isEmpty()) throw new RuntimeException("No function definitions found in source passed to defineFunction().");

        for (Map.Entry<String, RootCallTarget> e : newFunc.entrySet()) {
            functionTable.put(e.getKey(), e.getValue());
            VFunction.redefine(e.getKey(), e.getValue());
            e.getValue().setFunctionTable(functionTable);
        }

        return new VString(src);
    }

    @Override
    public byte[] getCode() {
        throw new RuntimeException("Built-in doesn't have a bytecode!");
    }

    @Override
    public List<Object> getPool() {
        throw new RuntimeException("Built-in doesn't have a constant pool that goes along a bytecode!");
    }

    @Override
    public void setFunctionTable(Map<String, RootCallTarget> tb) {}

    @Override
    public void setTracer(BciTracer stderr) {
        // stderr.onExec(0xFFFF, OpCode.DEF_FUN, null);
    }
}
