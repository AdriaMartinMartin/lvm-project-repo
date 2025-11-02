package nl.tue.vmcourse.toy.builtins;

import nl.tue.vmcourse.toy.interpreter.ToyRootNode;
import nl.tue.vmcourse.toy.lang.FrameDescriptor;
import nl.tue.vmcourse.toy.lang.RootCallTarget;

import java.util.Map;
import java.util.Set;

public final class BuiltinBuilder {
    private BuiltinBuilder() {}

    private static final Set<String> reserved_names = Set.of("println", "new", "getSize", "nanoTime",
            "typeOf", "defineFunction", "eval", "stacktrace", "helloEqualsWorld", "subString", "isInstance",
            "hasProperty", "deleteProperty", "hasSize", "stringSplit");

    public static void build(Map<String, RootCallTarget> functionTable) {

        FrameDescriptor.Builder builder = FrameDescriptor.newBuilder();

        builder.addParam("String string");
        ToyRootNode rNode = new ToyRootNode(builder.build(), new PrintBuiltin(), "println");
        RootCallTarget rcTarget = new RootCallTarget(rNode);

        functionTable.put("println", rcTarget);

        builder = FrameDescriptor.newBuilder();
        ToyRootNode rNode_1 = new ToyRootNode(builder.build(), new NewBuiltin(), "new");
        RootCallTarget rcTarget_1 = new RootCallTarget(rNode_1);

        functionTable.put("new", rcTarget_1);


        builder = FrameDescriptor.newBuilder();
        builder.addParam("VObject o");
        ToyRootNode rNode_2 = new ToyRootNode(builder.build(), new GetSizeBuiltin(), "getSize");
        RootCallTarget rcTarget_2 = new RootCallTarget(rNode_2);

        functionTable.put("getSize", rcTarget_2);

        builder = FrameDescriptor.newBuilder();
        ToyRootNode rNode_3 = new ToyRootNode(builder.build(), new NanoTimeBuiltin(), "nanoTime");
        RootCallTarget rcTarget_3 = new RootCallTarget(rNode_3);

        functionTable.put("nanoTime", rcTarget_3);

        builder = FrameDescriptor.newBuilder();
        builder.addParam("Value value");
        ToyRootNode rNode_4 = new ToyRootNode(builder.build(), new TypeOfBuiltin(functionTable), "typeOf");
        RootCallTarget rcTarget_4 = new RootCallTarget(rNode_4);

        functionTable.put("typeOf", rcTarget_4);

        builder = FrameDescriptor.newBuilder();
        builder.addParam("String fun");
        ToyRootNode rNode_5 = new ToyRootNode(builder.build(), new DefineFunctionBuiltin(functionTable), "defineFunction");
        RootCallTarget rcTarget_5 = new RootCallTarget(rNode_5);

        functionTable.put("defineFunction", rcTarget_5);

        builder = FrameDescriptor.newBuilder();
        builder.addParam("String lan");
        builder.addParam("String func");
        ToyRootNode rNode_6 = new ToyRootNode(builder.build(), new EvalBuiltin(functionTable), "eval");
        RootCallTarget rcTarget_6 = new RootCallTarget(rNode_6);

        functionTable.put("eval", rcTarget_6);

        builder = FrameDescriptor.newBuilder();
        ToyRootNode rNode_7 = new ToyRootNode(builder.build(), new StackTraceBuiltin(functionTable), "stacktrace");
        RootCallTarget rcTarget_7 = new RootCallTarget(rNode_7);

        functionTable.put("stacktrace", rcTarget_7);

        builder = FrameDescriptor.newBuilder();
        ToyRootNode rNode_8 = new ToyRootNode(builder.build(), new HelloEqualsWorld(), "helloEqualsWorld");
        RootCallTarget rcTarget_8 = new RootCallTarget(rNode_8);

        functionTable.put("helloEqualsWorld", rcTarget_8);

        builder = FrameDescriptor.newBuilder();
        builder.addParam("String str");
        builder.addParam("Integer s");
        builder.addParam("Integer e");
        ToyRootNode rNode_9 = new ToyRootNode(builder.build(), new SubString(), "subString");
        RootCallTarget rcTarget_9 = new RootCallTarget(rNode_9);

        functionTable.put("subString", rcTarget_9);


        builder = FrameDescriptor.newBuilder();
        builder.addParam("Type t");
        builder.addParam("Value v");
        ToyRootNode rNode_10 = new ToyRootNode(builder.build(), new IsInstance(), "isInstance");
        RootCallTarget rcTarget_10 = new RootCallTarget(rNode_10);

        functionTable.put("isInstance", rcTarget_10);

        builder = FrameDescriptor.newBuilder();
        builder.addParam("Object o");
        builder.addParam("Value k");
        ToyRootNode rNode_11 = new ToyRootNode(builder.build(), new HasProperty(), "hasProperty");
        RootCallTarget rcTarget_11 = new RootCallTarget(rNode_11);

        functionTable.put("hasProperty", rcTarget_11);

        builder = FrameDescriptor.newBuilder();
        builder.addParam("Object o");
        builder.addParam("Value k");
        ToyRootNode rNode_12 = new ToyRootNode(builder.build(), new DeleteProperty(), "deleteProperty");
        RootCallTarget rcTarget_12 = new RootCallTarget(rNode_12);

        functionTable.put("deleteProperty", rcTarget_12);


        builder = FrameDescriptor.newBuilder();
        builder.addParam("Value v");
        ToyRootNode rNode_13 = new ToyRootNode(builder.build(), new HasSize(), "hasSize");
        RootCallTarget rcTarget_13 = new RootCallTarget(rNode_13);

        functionTable.put("hasSize", rcTarget_13);

        builder = FrameDescriptor.newBuilder();
        builder.addParam("String v");
        ToyRootNode rNode_14 = new ToyRootNode(builder.build(), new StringSplit(), "stringSplit");
        RootCallTarget rcTarget_14 = new RootCallTarget(rNode_14);

        functionTable.put("stringSplit", rcTarget_14);
    }

    public static boolean reservedName(String functionName) {
        return reserved_names.contains(functionName);
    }
}
