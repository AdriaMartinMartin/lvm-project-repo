package nl.tue.vmcourse.toy.interpreter;

import nl.tue.vmcourse.toy.lang.RootCallTarget;
import nl.tue.vmcourse.toy.lang.VirtualFrame;

import java.util.Map;

public abstract class ToyAbstractFunctionBody extends ToyNode {

    public abstract Object execute(VirtualFrame frame);

    public abstract void setFunctionTable(Map<String, RootCallTarget> tb);
}
