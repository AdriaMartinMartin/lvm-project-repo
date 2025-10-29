package nl.tue.vmcourse.toy.bci.value;

public interface ConstantUnboxer<V extends Value> {
    Object unbox(V value);
}