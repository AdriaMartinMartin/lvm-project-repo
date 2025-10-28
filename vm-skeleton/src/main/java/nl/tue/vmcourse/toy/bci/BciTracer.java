package nl.tue.vmcourse.toy.bci;

import nl.tue.vmcourse.toy.bci.value.Value;

import java.io.PrintStream;
import java.util.Deque;

public interface BciTracer {
    void onExec(int pc, byte opcode, Deque<Value> stackView);
    static BciTracer stderr(PrintStream err) {
        return (pc, opcode, stack) -> {
            err.printf("[pc=%04x] %s  stack=%s%n", pc, OpCode.nameOf(opcode), stack);
        };
    }
}