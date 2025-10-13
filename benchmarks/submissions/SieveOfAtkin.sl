/*
 * Test Type: benchmark
 * Adapted from: https://www.geeksforgeeks.org/dsa/sieve-of-atkin/
 */

// iteratively find the square root
function sqrt(n) {
    s = 1;
    while (s * s <= n) {
        s = s + 1;
    }

    return s - 1;
}

function mod(a, b) {
    if (a == 0 || b == 0) {
        return 0;
    }
    q = a / b;
    return a - b * q;
}

function sieveOfAtkin(limit) {
    a = new();

    // initialize limit+1 values to 0
    i = 0;
    while (i <= limit + 1) {
        a[i] = 0;
        i = i + 1;
    }

    // edge case: 2
    if (limit > 2) {
        a[2] = 1;
    }

    // edge case: 3
    if (limit > 3) {
        a[3] = 1;
    }

    // check conditions
    x = 1;
    while (x <= sqrt(limit)) {
        y = 1;
        while (y <= sqrt(limit)) {

            // condition 1
            n = (4 * x * x) + (y * y);
            if (n <= limit && (mod(n, 12) == 1 || mod(n, 12) == 5)) {
                a[n] = mod(a[n] + 1, 2);
            }

            // condition 2
            n = (3 * x * x) + (y * y);
            if (n <= limit && mod(n, 12) == 7) {
                a[n] = mod(a[n] + 1, 2);
            }

            // condition 3
            n = (3 * x * x) - (y * y);
            if (x > y && n <= limit && mod(n, 12) == 11) {
                a[n] = mod(a[n] + 1, 2);
            }

            y = y + 1;
        }

        x = x + 1;
    }

    // mark all multiples of squares as non-prime
    i = 5;
    while (i <= limit) {
        if (i * i > limit) {
            break;
        }

        if (a[i] == 0) {
            i = i + 1;
            continue;
        }

        j = i * i;
        while (j <= limit) {
            a[j] = 0;
            j = j + i * i;
        }

        i = i + 1;
    }

    primes = new();
    prime = 2;
    i = 0;
    while (prime <= limit) {
        if (a[prime] == 1) {
            primes[i] = prime;
            i = i + 1;
        }
        prime = prime + 1;
    }

    return primes;
}

function benchmark() {
    primes = sieveOfAtkin(4000);
    if (primes[getSize(primes) - 1] != 3989) {
        println("Benchmark failed!");
    }
}

function main() {
    //
    // benchmark constants
    //
    ITERATIONS = 10000;
    MEASURE_FROM = 8000;
    NAME = "Sieve of Atkin";

    //
    // harness
    //
    time = 0;
    it = 0;

    while (it < ITERATIONS) {
        s = nanoTime();
        benchmark();
        e = nanoTime() - s;
        if (it >= MEASURE_FROM) {
            time = time + e;
        }
        it = it + 1;
    }

    avg = time / (ITERATIONS - MEASURE_FROM);
    // Make sure you print the final result -- and no other things!
    println(NAME + ": " + avg);
}