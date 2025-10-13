// [objects/arrays] has/delete properties test

function main() {
    // Props
    o = new();
    println(hasProperty(o, "x"));  // false
    o["x"] = 55;
    println(hasProperty(o, "x"));  // true
    println(o["x"]);               // 55
    println(deleteProperty(o, "x")); // true
    println(hasProperty(o, "x"));  // false

    // Array indices behave as properties, too
    a = new();
    a[1] = "something";
    println(getSize(a));           // 1
    println(hasProperty(a, "1"));    // true
    println(deleteProperty(a, "1")); // true
    println(hasProperty(a, "1"));    // false
    println(getSize(a));           // 0
}