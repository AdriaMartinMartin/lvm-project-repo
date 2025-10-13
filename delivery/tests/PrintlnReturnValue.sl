/* PrintlnReturnValue.sl                           [other]
 *
 * This unit test if the built-in function `println` has a
 * return value. It extends also to check how it reacts to
 * different inputs as; numbers, strings, objects, func...
 *
 * Also checks if the functions is assignable to other
 * variables and how they react.
 */

function foo() { return println; }

function main() {
    val = println("Hello World!");      // Hello World!
    println(val);                       // Hello World!

    // val = println(foo);              // Runtime error on "println": Unknown object: "foo"
    // println(val);

    // val = println(foo());            // Runtime error on "println": Unknown object: "println"
    // println(val);

    val = foo();
    val("Hello World!");                // Hello World!
}