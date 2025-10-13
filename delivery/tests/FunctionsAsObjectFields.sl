/* FunctionsAsObjectFields.sl                                                                [objects/arrays]
 * This unit test asserts that: a function stored in an object field can be invoked; field can be reassigned.
 */

function foo() { return "foo"; }
function bar() { return "bar"; }

function main() {
    obj = new();

    obj.fn = foo;
    println(obj.fn());      // foo

    obj.fn = bar;
    println(obj.fn());      // bar
}