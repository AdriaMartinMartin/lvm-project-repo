// TYPE: "array/object" tests
function main() {
    mixed = new();
    
    // Different value types
    mixed[0] = 42;
    mixed["str"] = "hello";
    mixed[true] = "boolean key";
    mixed[null] = "null key";
    
    println(mixed[0]);
    if (mixed[0] != 42) {
        println("ERROR: numeric index failed");
    }
    
    println(mixed["str"]);
    if (mixed["str"] != "hello") {
        println("ERROR: string key failed");
    }
    
    println(mixed[true]);
    if (mixed[true] != "boolean key") {
        println("ERROR: boolean key failed");
    }
    
    println(mixed[null]);
    if (mixed[null] != "null key") {
        println("ERROR: null key failed");
    }
    
    // Object as key
    keyObj = new();
    mixed[keyObj] = "object key";
    println(mixed[keyObj]);
    if (mixed[keyObj] != "object key") {
        println("ERROR: object as key failed");
    }
    
    println("size: " + getSize(mixed));
    if (getSize(mixed) != 5) {
        println("ERROR: mixed size wrong");
    }
}