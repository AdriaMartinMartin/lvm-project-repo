package nl.tue.vmcourse.toy.bci.value;

public class VNull implements Value {
    private static final VNull instance = new VNull();

    private VNull() {};

    public static VNull getInstance() {
        return instance;
    }

    @Override
    public Value add(Value r) {
        throw new RuntimeException("");
    }

    @Override
    public void print() {
        System.out.println("NULL");
    }
}
