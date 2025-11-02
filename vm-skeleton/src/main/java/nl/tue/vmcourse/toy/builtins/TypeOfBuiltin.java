package nl.tue.vmcourse.toy.builtins;

import nl.tue.vmcourse.toy.bci.BciTracer;
import nl.tue.vmcourse.toy.bci.OpCode;
import nl.tue.vmcourse.toy.bci.value.*;
import nl.tue.vmcourse.toy.interpreter.ToyAbstractFunctionBody;
import nl.tue.vmcourse.toy.lang.RootCallTarget;
import nl.tue.vmcourse.toy.lang.VirtualFrame;

import java.util.List;
import java.util.Map;

public class TypeOfBuiltin extends ToyAbstractFunctionBody {
    private final Map<String, RootCallTarget> fTable;

    public TypeOfBuiltin(Map<String, RootCallTarget> fTable) {
        this.fTable = fTable;
    }

    @Override
    public Object execute(VirtualFrame frame) {
        assert frame.size() == 1 && frame.get(0) instanceof Value;
        Value v = (Value) frame.get(0);

        String type = "NULL";
        if (v instanceof VLong || v instanceof VBigInteger) type = "Number";
        else if (v instanceof VString) type = "String";
        else if (v instanceof VBool) type = "Boolean";
        else if (v instanceof VNull) type = "NULL";
        else if (v instanceof VObject) type = "Object";
        else if (v instanceof VFunction && fTable.containsKey(((VFunction) v).getName())) type = "Function";
        else if (v instanceof VType) type = "Type";

        return new VType(type);
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
    public void setFunctionTable(Map<String, RootCallTarget> tb) {
    }

    @Override
    public void setTracer(BciTracer stderr) {
        stderr.onExec(0xFFFF, OpCode.TYPE_OF, null);
    }
}
