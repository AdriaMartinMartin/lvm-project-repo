function mod(n, b) {
    res = n - (b * (n / b));
    return res;
}

function abs(n) {
    if (n < 0) {
        return n * (-1);
    } else {
        return n;
    }
}

function gcd(a, b) {
    while (b != 0) {
        t = b;
        b = mod(a, b);
        a = t;
    }

    return a;
}

function g(x, n) {
    res = x * x + 3;
    return mod(res, n);
}

function polland_rho(n) {
    x = 2;
    y = x;
    d = 1;

    while (d == 1) {
        x = g(x, n);
        gy = g(y, n);
        y = g(gy, n);

        xy = x - y;
        absxy = abs(xy);
        d = gcd(absxy, n);
    }

    if (d == n) {
        return -1;
    }

    return d;
}


function benchmark() {
    prime1 = 1913489;
    prime2 = 7913179;
    key = prime1 * prime2;

    res = polland_rho(key);

    if (res != prime1) {
        println("Benchmark failed!");
    }

}

function main() {
    ITERATIONS = 10000;
    MEASAURE_FROM = 8000;
    NAME = "Integer Factorization";

    time = 0;
    it = 0;

    while (it < ITERATIONS) {
        s = nanoTime();
        benchmark();
        e = nanoTime() - s;
        if (it >= MEASAURE_FROM) {
            time = time + e;
        }
        it = it + 1;
    }

    avg = time / (ITERATIONS - MEASAURE_FROM);

    println(NAME + ": " + avg);
}