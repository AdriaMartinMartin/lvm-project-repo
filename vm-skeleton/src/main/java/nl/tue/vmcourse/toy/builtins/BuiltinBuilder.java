package nl.tue.vmcourse.toy.builtins;

import nl.tue.vmcourse.toy.interpreter.ToyRootNode;
import nl.tue.vmcourse.toy.lang.FrameDescriptor;
import nl.tue.vmcourse.toy.lang.RootCallTarget;

import java.util.Collection;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

public final class BuiltinBuilder {
    private BuiltinBuilder() {}

    private static final Set<String> reserved_names = Set.of("println", "new", "getSize");

    public static void build(Map<String, RootCallTarget> functionTable) {

        FrameDescriptor.Builder builder = FrameDescriptor.newBuilder();

        builder.addSlot("String string");
        ToyRootNode rNode = new ToyRootNode(builder.build(), new PrintBuiltin(), "println");
        RootCallTarget rcTarget = new RootCallTarget(rNode);

        functionTable.put("println", rcTarget);

        builder = FrameDescriptor.newBuilder();
        ToyRootNode rNode_1 = new ToyRootNode(builder.build(), new NewBuiltin(), "new");
        RootCallTarget rcTarget_1 = new RootCallTarget(rNode_1);

        functionTable.put("new", rcTarget_1);


        builder = FrameDescriptor.newBuilder();
        builder.addSlot("VObject o");
        ToyRootNode rNode_2 = new ToyRootNode(builder.build(), new GetSizeBuiltin(), "getSize");
        RootCallTarget rcTarget_2 = new RootCallTarget(rNode_2);

        functionTable.put("getSize", rcTarget_2);
    }

    public static boolean reservedName(String functionName) {
        return reserved_names.contains(functionName);
    }
}
