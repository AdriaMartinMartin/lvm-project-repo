package nl.tue.vmcourse.toy.bci.value;

import java.util.Objects;

public class TransitionKey {
    public enum Operation {ADD, DEL}

    public final Operation op;
    public final String key;

    public TransitionKey(Operation op, String key) {
        this.op = op;
        this.key = key;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof TransitionKey)) return false;

        TransitionKey tk = (TransitionKey) o;
        return op == tk.op && Objects.equals(key, tk.key);
    }

    @Override
    public int hashCode() {
        return Objects.hash(op, key);
    }

    @Override
    public String toString() {
        return op + " : " + key;
    }
}
