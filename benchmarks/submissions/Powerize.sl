// Benchmark

function remainder(x, y) {
    return x - (x / y) * y;
} 

function divides(x, y) {
    return remainder(y, x) == 0;
}

function isOdd(x) {
    return (x / 2) * 2 != x;
}

function gcd(x, y) {
    if (x == 0) {
        return y;
    }
    if (y == 0) {
        return x;
    }
    return gcd(y, remainder(x, y));
}

function gcdOfList(x) {
    len = getSize(x);
    g = 0;
    i = 0;
    while (i < len) {
        g = gcd(g, x[i]);
        i = i + 1;
    }
    return g;
}

function power(x, y) {
    z1 = x;
    z2 = 1;
    while (y > 0) {
        if (isOdd(y)) {
            z2 = z1 * z2;
            y = y - 1;
        }
        y = y / 2;
        z1 = z1 * z1;
    }
    return z2;
}

function factorize(x) {
    p = new();
    pe = new();
    len = 0;
    y = 2;
    while (y * y <= x) {
        // invariant len == getSize(p) == getSize(pe)
        // invariant forall x in p :: pe[x] exists
        // invariant forall 0 <= x < len :: p[x] exists

        if (divides(y, x)) {
            p[len] = y;
            len = len + 1;
            pe[y] = 1;
            x = x / y;
            while (divides(y, x)) {
                x = x / y;
                pe[y] = pe[y] + 1;
            }
        }
        if (y == 2) {
            y = y + 1;
        }
        else {
            y = y + 2;
        }
    }
    if (x > 1) {
        p[len] = x;
        len = len + 1;
        pe[x] = 1;
    }
    p.e = pe;
    p.len = len;
    return p;
}

function powerize(x) {
    f = factorize(x);
    list = new();
    i = 0;
    while (i < f.len) {
        list[i] = f.e[f[i]];
        i = i + 1;
    }
    g = gcdOfList(list);
    result = new();
    result.base = 1;
    result.exp = g;
    i = 0;
    if (g > 0) {
        while (i < f.len) {
            p = f[i];
            result.base = result.base * power(p, f.e[p] / g);
            i = i + 1;
        }
    }
    return result;
}

function benchmark(print) {
    f = powerize(642441308484426621115020474437255996015625);
    s = result2String(f);

    if (s != "938745^7") {
        println("Benchmark failed!");
    }
}  

function main() {
    //
    // benchmark constants
    //
    ITERATIONS = 10000;
    MEASURE_FROM = 8000;
    NAME = "Factorize";

    //
    // harness
    //
    time = 0;
    it = 0;

    while (it < ITERATIONS) {
        s = nanoTime();
        benchmark(it == 0);
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

function primes2String(p) {
    if (p.len < 1) {
        return "[]";
    }
    string = "[" + p[0] + ": " + p.e[p[0]];
    i = 1;
    while (i < p.len) {
        b = p[i];
        e = p.e[b];
        string = string + ", " + b + ": " + e;
        i = i + 1;
    }
    string = string + "]";
    return string;
}

function result2String(r) {
    return r.base + "^" + r.exp;
}