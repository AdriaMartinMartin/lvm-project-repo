// Objects tests

function main(){
    a = new();
    b = new();
    a.ref = b;
    b.ref = a;

    // Create a self-reference too
    a.self = a;
    b.self = b;

    println(a.ref == b); // Should return true
    println(b.ref == a); // Should return true
    println(a.self == a); // Should return true
    println(b.self == b); // Should return true


    // Change a.ref value
    a.ref = "test";
    println(a.ref == b); // Should return false

    // Change a.self value
    a.self = "test";
    println((a.self == a)); // Should return false

    // b.ref == a stays the same
    println((b.ref == a)); // Should return true

    // Create new Objects
    d = new();
    e = new();
    d.ref = e;
    e.ref = d;

    // before swapping
    println((d.ref == d)); // Should return false
    println((d.ref == e)); // Should return true
    println((e.ref == e)); // Should return false
    println((e.ref == d)); // Should return true

    // Swap references
    temp = d.ref;
    d.ref = e.ref;
    e.ref = temp;
    // After swapping
    println((d.ref == d)); // Should return true
    println((d.ref == e)); // Should return false
    println((e.ref == e)); // Should return true
    println((e.ref == d)); // Should return false

    // Nested self-reference
    f = new();
    f.nested = new();
    f.nested.self = f.nested;

    println((f.nested.self == f.nested)); // Should return true
    println((f.nested.self == f)); // Should return false
}