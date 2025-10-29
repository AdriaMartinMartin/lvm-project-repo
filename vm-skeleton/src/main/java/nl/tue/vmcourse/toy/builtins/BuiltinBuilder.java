package nl.tue.vmcourse.toy.builtins;

import nl.tue.vmcourse.toy.interpreter.ToyRootNode;
import nl.tue.vmcourse.toy.lang.FrameDescriptor;
import nl.tue.vmcourse.toy.lang.RootCallTarget;

import java.util.Map;
import java.util.Set;

public final class BuiltinBuilder {
    private BuiltinBuilder() {}

    private static final Set<String> reserved_names = Set.of("println", "new", "getSize", "nanoTime", "typeOf", "defineFunction", "eval");

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
        ToyRootNode rNode_4 = new ToyRootNode(builder.build(), new TypeOfBuiltin(), "typeOf");
        RootCallTarget rcTarget_4 = new RootCallTarget(rNode_4);

        functionTable.put("typeOf", rcTarget_4);

        builder = FrameDescriptor.newBuilder();
        builder.addParam("String func");
        ToyRootNode rNode_5 = new ToyRootNode(builder.build(), new DefineFunctionBuiltin(functionTable), "defineFunction");
        RootCallTarget rcTarget_5 = new RootCallTarget(rNode_5);

        functionTable.put("defineFunction", rcTarget_5);

        builder = FrameDescriptor.newBuilder();
        builder.addParam("String lan");
        builder.addParam("String func");
        ToyRootNode rNode_6 = new ToyRootNode(builder.build(), new EvalBuiltin(functionTable), "eval");
        RootCallTarget rcTarget_6 = new RootCallTarget(rNode_6);

        functionTable.put("eval", rcTarget_6);
    }

    public static boolean reservedName(String functionName) {
        return reserved_names.contains(functionName);
    }
}
