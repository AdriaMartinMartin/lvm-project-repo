package nl.tue.vmcourse.toy.lang;

import nl.tue.vmcourse.toy.bci.BciTracer;
import nl.tue.vmcourse.toy.interpreter.ToyRootNode;

import java.util.List;
import java.util.Map;

public class RootCallTarget {
    private final ToyRootNode rootNode;

    public RootCallTarget(ToyRootNode rootNode) {
        this.rootNode = rootNode;
    }

    public Object invoke(Object... arguments) {
        VirtualFrame frame = new VirtualFrame(arguments);
        return rootNode.execute(frame);
    }

    public void setFunctionTable(Map<String, RootCallTarget> tb) { rootNode.setFunctionTable(tb); }

    public final int getArity() { return rootNode.getArity(); }
    public int getLocalCount() { return rootNode.getLocalCount(); }
    public String getLocalName(int idx) { return rootNode.getLocalName(idx); }
    public final String getName() { return rootNode.getName(); }
    public final byte[] getCode() { return rootNode.getCode(); }
    public final List<Object> getPool() { return rootNode.getPool(); }

    public void setTracer(BciTracer stderr) { rootNode.setTracer(stderr); }
}