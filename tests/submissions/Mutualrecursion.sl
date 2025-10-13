// [other] Testing mutual recursion even/odd

function isEven(n) {
    if (n < 0) {
        n = 0 - n;
    }
    if (n == 0) {
        return true;
    }

    return isOdd(n - 1);
}

function isOdd(n) {
    if (n < 0) {
        n = 0 - n;
    }
    if (n == 0) {
        return false;
    }

    return isEven(n - 1);
}

function main() {
    println(isEven(0)); // true
    println(isOdd(7)); // true
    println(isEven(15)); //false
    println(isOdd(-4)); // false
    println(isEven(-123)); // false
    println(isOdd(53)); // true
}