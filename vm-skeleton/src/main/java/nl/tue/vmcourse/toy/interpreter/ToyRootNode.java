package nl.tue.vmcourse.toy.interpreter;

import nl.tue.vmcourse.toy.bci.BciTracer;
import nl.tue.vmcourse.toy.lang.FrameDescriptor;
import nl.tue.vmcourse.toy.lang.RootCallTarget;
import nl.tue.vmcourse.toy.lang.VirtualFrame;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ToyRootNode extends ToyNode {
    private final FrameDescriptor frameDescriptor;
    private final ToyAbstractFunctionBody functionBodyNode;
    private final String functionName;
    private final RootCallTarget callTarget;

    public ToyRootNode(FrameDescriptor build, ToyAbstractFunctionBody functionBodyNode, String functionName) {
        this.frameDescriptor = build;
        this.functionBodyNode = functionBodyNode;
        this.functionName = functionName;
        this.callTarget = new RootCallTarget(this);
    }

    public RootCallTarget getCallTarget() {
        return callTarget;
    }

    public Object execute(VirtualFrame frame) {
        return functionBodyNode.execute(frame);
    }

    public void setFunctionTable(Map<String, RootCallTarget> tb) { functionBodyNode.setFunctionTable(tb); }

    public int getArity() { return frameDescriptor.getArity(); }
    public int getLocalCount() { return frameDescriptor.getLocalCount(); }
    public String getLocalName(int idx) { return frameDescriptor.getLocalName(idx); }
    public String getName() { return functionName; }
    public final byte[] getCode() { return functionBodyNode.getCode(); }
    public final List<Object> getPool() { return functionBodyNode.getPool(); }

    public void setTracer(BciTracer stderr) { functionBodyNode.setTracer(stderr); }
}
