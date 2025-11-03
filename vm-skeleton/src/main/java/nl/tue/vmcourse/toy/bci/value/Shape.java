package nl.tue.vmcourse.toy.bci.value;

import java.util.HashMap;
import java.util.Map;

public final class Shape {
    public final static Shape EMPTY_SHAPE = new Shape(null, Map.of(), new HashMap<>());

    public final Map<String, Integer> propToSlot;
    private final Map<TransitionKey, Shape> transitions;

    public final Shape parent; // Debug only

    private Shape(Shape parent, Map<String, Integer> propToSlot,Map<TransitionKey, Shape> transitions) {
        this.parent = parent;
        this.propToSlot = propToSlot;
        this.transitions = transitions;
    }

    public Shape addProperty(String key) {
        TransitionKey tk = new TransitionKey(TransitionKey.Operation.ADD, key);
        Shape nextShape = transitions.get(tk);
        if (nextShape != null) return nextShape;

        int slot = propToSlot.size();
        var newSlots = new HashMap<>(propToSlot);
        newSlots.put(key, slot);

        nextShape = new Shape(this, Map.copyOf(newSlots), new HashMap<>());
        transitions.put(tk, nextShape);
        return nextShape;
    }

    public Shape deleteProperty(String key) {
        TransitionKey tk = new TransitionKey(TransitionKey.Operation.DEL, key);
        Shape nextShape = transitions.get(tk);
        if (nextShape != null) return nextShape;

        if (!propToSlot.containsKey(key)) return this;

        var newSlots = new HashMap<>(propToSlot);
        newSlots.remove(key);


        nextShape = new Shape(this, Map.copyOf(newSlots), new HashMap<>());
        transitions.put(tk, nextShape);
        return nextShape;
    }

    public Integer slotOf(String key) { return propToSlot.get(key); }
}
