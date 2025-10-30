package nl.tue.vmcourse.toy.lang;

public class VirtualFrame {
    private final Object[] arguments;

    public Object get(int i) { return arguments[i]; }
    public final Object[] getArguments() { return arguments; }
    public int size() { return arguments.length; }

    public VirtualFrame(Object[] arguments) {
        this.arguments = arguments;
    }
}
