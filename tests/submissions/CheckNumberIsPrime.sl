/*
 *  Test 1 computations 
 */

function main() {
    println(checkPrime(2));
    println(checkPrime(43));
    println(checkPrime(59));
    println(checkPrime(44));
    println(checkPrime(81));
    println(checkPrime(72));
}

function checkPrime(n) {
    if (n < 2) {
        return false;
    }

    i = 2;
    while (i * i <= n) {
        if ((n / i) * i == n) {
            return false;
        }
        i = i + 1;
    }

    return true;
}