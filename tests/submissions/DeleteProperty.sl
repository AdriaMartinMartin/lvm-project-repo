/*
 * Test Type: array/object
 */

function main() {
    obj = new();
    obj.a = 1;
    println("Property 'a' exists: " + hasProperty(obj, "a"));

    deleteProperty(obj, "a");
    println("Property 'a' exists: " + hasProperty(obj, "a"));
}