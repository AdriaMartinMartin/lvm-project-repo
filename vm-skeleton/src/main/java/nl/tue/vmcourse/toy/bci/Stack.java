package nl.tue.vmcourse.toy.bci;

import nl.tue.vmcourse.toy.bci.value.VLong;
import nl.tue.vmcourse.toy.bci.value.VString;
import nl.tue.vmcourse.toy.bci.value.Value;

import java.util.ArrayDeque;
import java.util.Deque;

public class Stack {
    private final ArrayDeque<Value> stack = new ArrayDeque<>();

    void push(Value v) { stack.push(v); }
    Value pop() { return stack.pop(); }
    Value peek() { return stack.peek(); }
    final Deque<Value> view() { return stack; }
    public void clear() { stack.clear(); }
    public int size() { return stack.size(); }

    // Type-based push/retrieve
    void pushLong(long l) { push(new VLong(l));}
    void pushString(String s) { push(new VString(s));}

    public boolean isEmpty() {
        return stack.isEmpty();
    }

}
