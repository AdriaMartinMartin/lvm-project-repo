package nl.tue.vmcourse.toy.builtins;

import nl.tue.vmcourse.toy.bci.BciTracer;
import nl.tue.vmcourse.toy.bci.value.VLong;
import nl.tue.vmcourse.toy.bci.value.VObject;
import nl.tue.vmcourse.toy.interpreter.ToyAbstractFunctionBody;
import nl.tue.vmcourse.toy.lang.RootCallTarget;
import nl.tue.vmcourse.toy.lang.VirtualFrame;
import nl.tue.vmcourse.toy.bci.OpCode;

import java.util.List;
import java.util.Map;

public class GetSizeBuiltin extends ToyAbstractFunctionBody {
    @Override
    public Object execute(VirtualFrame frame) {
        assert frame.size() == 1 && frame.get(0) instanceof VObject;

        VObject arg = (VObject) frame.get(0);
        return new VLong(arg.size());
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
        stderr.onExec(0xFFFF, OpCode.GETSIZE, null);

    }
}
