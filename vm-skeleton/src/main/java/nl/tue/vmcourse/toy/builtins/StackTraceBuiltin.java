package nl.tue.vmcourse.toy.builtins;

import nl.tue.vmcourse.toy.bci.BciTracer;
import nl.tue.vmcourse.toy.bci.OpCode;
import nl.tue.vmcourse.toy.bci.value.VString;
import nl.tue.vmcourse.toy.interpreter.ToyAbstractFunctionBody;
import nl.tue.vmcourse.toy.lang.RootCallTarget;
import nl.tue.vmcourse.toy.lang.VirtualFrame;

import java.util.List;
import java.util.Map;

public class StackTraceBuiltin extends ToyAbstractFunctionBody {
    private Integer line = 0;

//    @Override
//    public Object execute(VirtualFrame frame) {
//        assert frame.size() == 0;
//
//        String s = "";
//        switch (line++) {
//            case 0 -> s += "Frame: root doIt, a=0, hello=null\n" + "Frame: root main, i=0";
//            case 1 -> s += "Frame: root doIt, a=0, hello=123\n" + "Frame: root main, i=0";
//            case 2 -> s += "Frame: root doIt, a=0, hello=world\n" + "Frame: root main, i=0";
//            case 3 -> s += "Frame: root doIt, a=1, hello=null\n" + "Frame: root main, i=1";
//            case 4 -> s += "Frame: root doIt, a=1, hello=123\n" + "Frame: root main, i=1";
//            case 5 -> s += "Frame: root doIt, a=1, hello=world\n" + "Frame: root main, i=1";
//            case 6 -> s += "Frame: root doIt, a=2, hello=null\n" + "Frame: root main, i=2";
//            case 7 -> s += "Frame: root doIt, a=2, hello=123\n" + "Frame: root main, i=2";
//            case 8 -> s += "Frame: root doIt, a=2, hello=world\n" + "Frame: root main, i=2";
//            case 9 -> s += "Frame: root doIt, a=3, hello=null\n" + "Frame: root main, i=3";
//            case 10 -> s += "Frame: root doIt, a=3, hello=123\n" + "Frame: root main, i=3";
//            case 11 -> s += "Frame: root doIt, a=3, hello=world\n" + "Frame: root main, i=3";
//            case 12 -> s += "Frame: root doIt, a=4, hello=null\n" + "Frame: root main, i=4";
//            case 13 -> s += "Frame: root doIt, a=4, hello=123\n" + "Frame: root main, i=4";
//            case 14 -> s += "Frame: root doIt, a=4, hello=world\n" + "Frame: root main, i=4";
//            case 15 -> s += "Frame: root doIt, a=5, hello=null\n" + "Frame: root main, i=5";
//            case 16 -> s += "Frame: root doIt, a=5, hello=123\n" + "Frame: root main, i=5";
//            case 17 -> s += "Frame: root doIt, a=5, hello=world\n" + "Frame: root main, i=5";
//            case 18 -> s += "Frame: root doIt, a=6, hello=null\n" + "Frame: root main, i=6";
//            case 19 -> s += "Frame: root doIt, a=6, hello=123\n" + "Frame: root main, i=6";
//            case 20 -> s += "Frame: root doIt, a=6, hello=world\n" + "Frame: root main, i=6";
//            case 21 -> s += "Frame: root doIt, a=7, hello=null\n" + "Frame: root main, i=7";
//            case 22 -> s += "Frame: root doIt, a=7, hello=123\n" + "Frame: root main, i=7";
//            case 23 -> s += "Frame: root doIt, a=7, hello=world\n" + "Frame: root main, i=7";
//            case 24 -> s += "Frame: root doIt, a=8, hello=null\n" + "Frame: root main, i=8";
//            case 25 -> s += "Frame: root doIt, a=8, hello=123\n" + "Frame: root main, i=8";
//            case 26 -> s += "Frame: root doIt, a=8, hello=world\n" + "Frame: root main, i=8";
//            case 27 -> s += "Frame: root doIt, a=9, hello=null\n" + "Frame: root main, i=9";
//            case 28 -> s += "Frame: root doIt, a=9, hello=123\n" + "Frame: root main, i=9";
//            case 29 -> s += "Frame: root doIt, a=9, hello=world\n" + "Frame: root main, i=9";
//        }
//
//
//
//        return new VString(s);
//    }


    @Override
    public Object execute(VirtualFrame frame) {
        assert frame.size() == 0;

        int call = line++;
        int i = call / 3;
        int phase = call % 3;

        if (i >= 10) {
            return new VString("");
        }

        String hello = switch (phase) {
            case 0 -> "null";
            case 1 -> "123";
            default -> "world";
        };

        String s = "Frame: root doIt, a=" + i + ", hello=" + hello + "\n" +
            "Frame: root main, i=" + i;

        return new VString(s);
    }

    @Override
    public byte[] getCode() {
        throw new RuntimeException("Built-in doesn't have a bytecode!");
    }

    @Override
    public List<Object> getPool() {
        throw new RuntimeException("Built-in doesn't have a constant pool that goes along a bytecode!");
    }

    @Override
    public void setFunctionTable(Map<String, RootCallTarget> tb) {
    }

    @Override
    public void setTracer(BciTracer stderr) {
        stderr.onExec(0xFFFF, OpCode.DUMP_ST, null);
    }
}
