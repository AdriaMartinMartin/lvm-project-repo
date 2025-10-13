// "computations" test.

// Test various recursive function calls.

// Performs 'it' recursive calls.
// Assumes it >= 0.
function simpleRecursion(it) {
    if (it == 0) {
        return;
    }
    // it > 0
    simpleRecursion(it - 1);
}

// Keep adding and subtracting 1 from a value in [0,1].
function zigzagRecursion(val, it) { 
    if (it == 0) {
        return val;
    }

    if (val == 0) {
        defineFunction("function func(val) { return val + 1; }"); 
    } else {
        defineFunction("function func(val) { return val - 1; }");
    }

    return zigzagRecursion(func(val), it - 1);
}

// Fold (sum) an array.
function fold(arr, it) {
    if (it == -1) {
        return 0;
    }
    if (it == 0) {
        if (getSize(arr) == 0) {
            return 0;
        }
    }

    return arr[it] + fold(arr, it - 1);
}

function main() {
    // Perform deep recursive calls, checking for stack overflows.
    simpleRecursion(400);
    println("sucessfully recursed.");

    // Test zigzag recursion.
    println(zigzagRecursion(0, 10));
    println(zigzagRecursion(0, 11));

    // Test a fold sum.
    arr = new();
    i = 50;
    while(i >= 0) {
        arr[i-1] = i;
        i = i - 1;
    }
    println(fold(arr, 10 - 1));
    println(fold(arr, 50 - 1));
}
