package nl.tue.vmcourse.toy.lang;

import java.util.ArrayList;

public class VirtualFrame {
    private final Object[] arguments;

    public Object get(int i) { return arguments[i]; }
    public int size() { return arguments.length; }

    public VirtualFrame(Object[] arguments) {
        this.arguments = arguments;
    }
}
