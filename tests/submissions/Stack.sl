/*
 * Other: Testing nested function calls and stacktrace
 */

function function1(x) {
    println("In function1 with x = " + x);
    println("Stack trace in function1:");
    println(stacktrace());
    
    function2(x + 1);
}

function function2(y) {
    println("In function2 with y = " + y);
    println("Stack trace in function2:");
    println(stacktrace());
    
    function3(y * 3);
}

function function3(z) {
    println("In function3 with z = " + z);
    println("Stack trace in function3:");
    println(stacktrace());
}

function main() {
    println("Initial stack trace in main:");
    println(stacktrace());
    
    function1(5);
}
