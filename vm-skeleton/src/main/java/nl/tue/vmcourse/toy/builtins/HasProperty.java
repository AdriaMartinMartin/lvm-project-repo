package nl.tue.vmcourse.toy.builtins;

import nl.tue.vmcourse.toy.bci.BciTracer;
import nl.tue.vmcourse.toy.bci.value.*;
import nl.tue.vmcourse.toy.interpreter.ToyAbstractFunctionBody;
import nl.tue.vmcourse.toy.interpreter.ToySyntaxErrorException;
import nl.tue.vmcourse.toy.lang.RootCallTarget;
import nl.tue.vmcourse.toy.lang.VirtualFrame;

import java.util.List;
import java.util.Map;

public class HasProperty extends ToyAbstractFunctionBody {

    @Override
    public Object execute(VirtualFrame frame) {
        assert frame.size() == 2 && frame.get(0) instanceof Value && frame.get(1) instanceof Value;

        Value raw_o = (Value) frame.get(0);
        Value k = (Value) frame.get(1);

        if (!(raw_o instanceof VObject))
            throw new ToySyntaxErrorException("Not an object!");

        if (!(k instanceof VString)) return new VBool(false);

        VObject o = (VObject) raw_o;
        try {
            return new VBool(o.has(k));
        } catch (ToySyntaxErrorException e) {
            return new VBool(false);
        }
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
        // stderr.onExec(0xFFFF, OpCode.HPROP, null);
    }
}
