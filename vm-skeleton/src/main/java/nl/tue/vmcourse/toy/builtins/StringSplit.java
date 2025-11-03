package nl.tue.vmcourse.toy.builtins;

import nl.tue.vmcourse.toy.bci.BciTracer;
import nl.tue.vmcourse.toy.bci.value.VObject;
import nl.tue.vmcourse.toy.bci.value.VString;
import nl.tue.vmcourse.toy.interpreter.ToyAbstractFunctionBody;
import nl.tue.vmcourse.toy.interpreter.ToySyntaxErrorException;
import nl.tue.vmcourse.toy.lang.RootCallTarget;
import nl.tue.vmcourse.toy.lang.VirtualFrame;

import java.util.List;
import java.util.Map;

public class StringSplit extends ToyAbstractFunctionBody {
    @Override
    public Object execute(VirtualFrame frame) {
        assert frame.size() == 1;

        if ((!(frame.get(0) instanceof VString)))
            throw new ToySyntaxErrorException("Not a string: cannot substring");

        String s = ((VString) frame.get(0)).v();
        String[] tokens = s.split(" ");
        VObject obj = new VObject();

        for (int i = 0; i < tokens.length; i++) {
            obj.set("" + i, new VString(tokens[i]));
        }

        return obj;
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
        // stderr.onExec(0xFFFF, OpCode.STR_SPT, null);
    }
}
