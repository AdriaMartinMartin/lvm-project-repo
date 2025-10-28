package nl.tue.vmcourse.toy.interpreter;

import nl.tue.vmcourse.toy.bci.BciTracer;
import nl.tue.vmcourse.toy.lang.RootCallTarget;
import nl.tue.vmcourse.toy.lang.VirtualFrame;

import java.util.List;
import java.util.Map;

public abstract class ToyAbstractFunctionBody extends ToyNode {

    public abstract Object execute(VirtualFrame frame);

    public abstract byte[] getCode();
    public abstract List<Object> getPool();

    public abstract void setFunctionTable(Map<String, RootCallTarget> tb);

    public abstract void setTracer(BciTracer stderr);
}
