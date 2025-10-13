// Computation test

function abs(n) {
    if (n < 0) {
        return n * (-1);
    } else {
        return n;
    }
}


function ceil_sqrt(n) { // very stupid square root function
    i = 1;
    while(i * i < n) {
        i = i + 1;
    }
    return i;
}

function round_sqrt(n) {
    i = 1;
    while(i * i <= n) {
        i = i + 1;
    }

    i = i - 1;

    lower_end = i * i;
    higher_end = (i + 1) * (i + 1);

    if (abs(n - lower_end) <= abs(n - higher_end)) {
        return i;
    } else {
        return i + 1;
    }
}

function main() {
    println(ceil_sqrt(69));
    println(round_sqrt(69));
    println(ceil_sqrt(420));
    println(round_sqrt(420));
    println(ceil_sqrt(1337));
    println(round_sqrt(1337));
    println(ceil_sqrt(10000));
    println(round_sqrt(10000));
    println(ceil_sqrt(10201));
    println(round_sqrt(10201));
}