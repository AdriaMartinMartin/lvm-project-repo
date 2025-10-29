package nl.tue.vmcourse.toy.lang;

import java.util.HashMap;
import java.util.Map;

public class FrameDescriptor {

    private int slotUids = 0;
    private int paramCount = 0;
    final Map<String, Integer> frameSlots = new HashMap<>();
    public static Builder newBuilder() {
        return new Builder();
    }

    public int getArity() { return paramCount; }

    public static class Builder {

        private final FrameDescriptor descriptor = new FrameDescriptor();
        public FrameDescriptor build() {
            return descriptor;
        }

        public Integer addSlot(String name) { return  addLocal(name); }

        public Integer addParam(String name) {
            if (!descriptor.frameSlots.containsKey(name)) {
                int uid = descriptor.slotUids++;
                descriptor.frameSlots.put(name, uid);
                descriptor.paramCount++;
            }

            return descriptor.frameSlots.get(name);
        }

        public Integer addLocal(String name) {
            if (!descriptor.frameSlots.containsKey(name)) {
                int uid = descriptor.slotUids++;
                descriptor.frameSlots.put(name, uid);
            }

            return descriptor.frameSlots.get(name);
        }


    }
}
