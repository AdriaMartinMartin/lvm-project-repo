package nl.tue.vmcourse.toy.bci.value;

@FunctionalInterface
public interface ConstantBoxer {
    Value box(Object constant);
}