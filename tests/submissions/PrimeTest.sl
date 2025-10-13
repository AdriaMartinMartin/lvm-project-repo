/*
 * Type of test: computations
 */

function mod(a, b) {
    return a - b * (a / b);
}

function isPrime(n) {
    if (n <= 2) {
        return false;
    }

    i = 2;
    while (i <= n / 2) {
        if (mod(n, i) == 0) {
            return false;
        }
        i = i + 1;
    }
    return true;
}

function main() {   
    println(isPrime(13));
    println(isPrime(20));
    println(isPrime(63));
    println(isPrime(7919));
    println(isPrime(4393139));
    println(isPrime(99999999999));
}