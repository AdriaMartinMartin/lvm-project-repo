package nl.tue.vmcourse.toy.bci.value;

public interface Value {
    Value NULL = VNull.getInstance();

    /**
     * Performs the 'add' operation against another value.
     * @param r The right-hand side of the operation.
     * @return A new Value representing the result.
     * @throws UnsupportedOperationException if the types cannot be added.
     */
    Value add(Value r);
    Value sub(Value r);
    Value mul(Value r);
    Value div(Value r);
    Value neg();
    Value lt(Value r);
    Value le(Value r);
    Value eq(Value r);
    String toString();
    String toErrString();
    int length();
    void print();

}