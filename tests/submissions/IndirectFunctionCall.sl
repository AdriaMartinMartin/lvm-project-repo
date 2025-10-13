/*
 * Test 2 other
 */

function foo() {
    println("foo called");
}

function bar() {
    println("bar called");
}

function main() {
    f = foo;
    f(); // foo called

    f = bar;
    f(); // bar called

    arr = new();
    arr[0] = foo;
    arr[1] = bar;
    arr[0](); // foo called
    arr[1](); // bar called
}