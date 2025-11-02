package nl.tue.vmcourse.toy.builtins;

import nl.tue.vmcourse.toy.bci.BciTracer;
import nl.tue.vmcourse.toy.bci.OpCode;
import nl.tue.vmcourse.toy.bci.value.VFunction;
import nl.tue.vmcourse.toy.bci.value.VString;
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

public class EvalBuiltin extends ToyAbstractFunctionBody {

    private final Map<String, RootCallTarget> functionTable;

    public EvalBuiltin(Map<String, RootCallTarget> functionTable) {
        this.functionTable = functionTable;
    }

    @Override
    public Object execute(VirtualFrame frame) {
        assert frame.size() == 2 && frame.get(0) instanceof VString && frame.get(1) instanceof VString;

        String lan = ((VString) frame.get(0)).v();
        String src = ((VString) frame.get(1)).v();

        if (!lan.equals("sl")) throw new RuntimeException("Unsuported language" + lan);

        try {
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
            if (newFunc.isEmpty())
                throw new RuntimeException("No function definitions found in source passed to eval().");

            for (Map.Entry<String, RootCallTarget> e : newFunc.entrySet()) {
                functionTable.put(e.getKey(), e.getValue());
                VFunction.redefine(e.getKey(), e.getValue());
                e.getValue().setFunctionTable(functionTable);
            }
        } catch (Exception e) {
            throw new ToySyntaxErrorException("Something went wrong parsing the eval function: " + e.getMessage());
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
        // stderr.onExec(0xFFFF, OpCode.EVAL, null);
    }
}
