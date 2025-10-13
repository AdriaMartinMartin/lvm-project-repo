/* FunctionFeatures.sl                                     [other]
 *
 * Asserts:
 *  - All functions in SL are top level, and accessible by anyone.
 *  - Nested function definitions are not supported (directly).
 *  - Functions aren't objects like in other dynamic languages.
 *  - `defineFunction` functions only live in the scope where
 *    they've been invoked.
 *  - No function hoisting.
 */

function foo() { println("foo"); }

function nest() {
    /* Error(s) parsing script :( -> it's not possible nesting functions (they aren't objects)
    fn = function nested() { println("I'm nested!!"); }
    return fn; */
}

function define() {
    val = defineFunction("function inc(a) { return a + 1; }");
    println(inc(2));
}

function main() {
    // println(foo);        // Runtime error -> functions aren't objects.
    foo();                  // foo
    // inc();               // Error(s) parsing script :( -> There's no declaration of the function yet.
    define();               // 3
    inc(2);                 // (nothing) -> definedFunctions have scope.
    // println(hoisting())  // Error(s) parsing script :( -> No function hoisting.

}

function hoisting() {
    return "I've been hoisted!";
}