/* ArraysObjectsAliasingAndCycles.sl    [objects/arrays]
 *
 * This unit test asserts that:
 *      1. Arrays can store objects and viceversa.
 *      2. Aliasing allows bidirectional bindings and cycles.
 *      3. Slots are dynamic: an index/field can change type
 *         (int, string, object, array).
 */

function main() {
    obj = new();
    arr = new();

    obj.arr = arr;
    arr[0] = obj;

    arr[1] = "hello";
    println(obj.arr[1]);     // hello

    obj.arr[2] = 99;
    println(arr[2]);         // 99

    arr[2] = "world";
    println(arr[2]);         // world

    arr[2] = obj;
    println(arr[2].arr[1]);  // hello (walks cycle)
}