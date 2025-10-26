package nl.tue.vmcourse.toy.bci;

import nl.tue.vmcourse.toy.bci.value.VLong;
import nl.tue.vmcourse.toy.bci.value.VString;
import nl.tue.vmcourse.toy.bci.value.Value;

import java.util.ArrayDeque;

public class Stack {
    private final ArrayDeque<Value> stack = new ArrayDeque<>();

    void push(Value v) { stack.push(v); }
    Value pop() { return stack.pop(); }
    Value peek() { return stack.peek(); }

    // Type-based push/retrieve
    void pushLong(long l) { push(new VLong(l));}
    void pushString(String s) { push(new VString(s));}

    public boolean isEmpty() {
        return stack.isEmpty();
    }
}
