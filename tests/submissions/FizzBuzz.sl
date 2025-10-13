// General test that doesn't target a specific language feature;
// it's an implementation of FizzBuzz that makes use of general programming principles
// (loops, control-flow, checks, calculations, and printing).
// NOTE: This test is not part of the 12 other specific tests; the FizzBuzz test was implemented just for fun.
function modulo(a, b) {
    div = a / b;
    return a - div * b;
}

function fizzbuzz(n) {
    i = 1;

    while (i <= n) {
        if (modulo(i, 3) == 0) {
            if (modulo(i, 5) == 0) {
                println("FizzBuzz");
            } else {
                println("Fizz");
            }

            i = i + 1;
            continue;
        }

        if (modulo(i, 5) == 0) {
            println("Buzz");

            i = i + 1;
            continue;
        }

        println(i);
        i = i + 1;
    }
}

function main() {
    fizzbuzz(100);
}