/*
 * Object/Array: Testing invalid property access on an object
 */

function main() {
    obj = new();
    obj.name = "Test Object";
    obj.value = 42;

    println(obj.name);   
    println(obj.value); 
    println(obj.nonexistent);
}