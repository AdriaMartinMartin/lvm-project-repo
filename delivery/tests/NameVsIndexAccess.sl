/* NameVsIndexAccess.sl                     [objects/arrays]
 *
 * This unit test asserts that:
 *      1. There is a single container kind (“object”); what
 *         differs is the access form.
 *      2. Field access: obj.field -> syntactic sugar for
 *         obj["field"]; the name must be an identifier.
 *      3. Index access: obj[key] -> key is any expression;
 *         numbers are coerced to strings (obj[0] == obj["0"]).
 *      4. `obj.0` is a parse error (not a type error).
 *          Using . or [] only matters by key shape, not by
 *          “array vs object”.
 */

function main() {
    obj = new();
    arr = new();

    obj.x = "Hello";
    arr[0] = "World";

    println(obj);                       // Object
    println(arr);                       // Object

    println(obj["x"]);                  // Hello

    // println(arr.0);                  // Error(s) parsing script :(

    obj["y"] = "Bye";
    obj["0"] = "mom!";

    // println(obj.y + " " + obj.0);    // Error(s) parsing script :(
    // println(obj.y + " " + obj."0");  // Error(s) parsing script :(
    println(obj.y + " " + obj["0"]);    // Bye mom!
    println(obj.y + " " + obj[0]);      // Bye mom!

    arr["x"] = "Bye";
    println(arr.x + " " + arr[0]);      // Bye World
}