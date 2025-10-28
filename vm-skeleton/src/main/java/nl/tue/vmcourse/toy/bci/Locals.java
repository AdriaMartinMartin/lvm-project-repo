package nl.tue.vmcourse.toy.bci;

import nl.tue.vmcourse.toy.bci.value.Value;

public class Locals {
    private Value[] slots;
    private final Integer maxSlot;


    public Locals(int size) {
        this.slots = new Value[size];
        this.maxSlot = size;

        for (int i = 0; i < size; i++) slots[i] = null;
    }

    Value get(int slot) {
        return slots[slot];
    }
    public void clear() { slots = new Value[maxSlot]; }

    void set(int slot, Value v) {
        if (slot < maxSlot)
            slots[slot] = v;
        else
            throw new RuntimeException("Slot  [" + slot + "] is out of bound. Too many variables/args.");
    }

    int size() {
        return maxSlot;
    }

}
