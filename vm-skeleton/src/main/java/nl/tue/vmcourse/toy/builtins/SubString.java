package nl.tue.vmcourse.toy.builtins;

import nl.tue.vmcourse.toy.bci.BciTracer;
import nl.tue.vmcourse.toy.bci.value.*;
import nl.tue.vmcourse.toy.interpreter.ToyAbstractFunctionBody;
import nl.tue.vmcourse.toy.interpreter.ToySyntaxErrorException;
import nl.tue.vmcourse.toy.lang.RootCallTarget;
import nl.tue.vmcourse.toy.lang.VirtualFrame;
import nl.tue.vmcourse.toy.bci.OpCode;

import java.util.List;
import java.util.Map;

public class SubString extends ToyAbstractFunctionBody {

    @Override
    public Object execute(VirtualFrame frame) {
        assert frame.size() == 3;

        if ((!(frame.get(0) instanceof VString)))
            throw new ToySyntaxErrorException("Not a string: cannot substring");

        String s = ((VString) frame.get(0)).v();

        Value sv = (Value) frame.get(1);
        Value e = (Value) frame.get(2);

        int start = -1;
        int end = -1;

        if (sv instanceof VLong) {
            start = (int) ((VLong) sv).v();
        } else if (e instanceof VBigInteger) {
            start = (int) ((VBigInteger) sv).v().intValue();
        }

        if (e instanceof VLong) {
            end = (int) ((VLong) e).v();
        } else if (e instanceof VBigInteger) {
            end = (int) ((VBigInteger) e).v().intValue();
        }

        if (start < 0 || start > s.length() || end < 0 || end > s.length() || start > end)
            throw new ToySyntaxErrorException("Exception occurred, see trace.log for more info\n");

        return new VString(s.substring(start, end));
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
        // stderr.onExec(0xFFFF, OpCode.SUB_STR, null);
    }
}