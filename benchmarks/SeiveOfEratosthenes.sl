/* SieveOfEratosthenes.sl
 *
 * This benchmark computes all prime numbers up to a `N`
 * limit using the Sieve of Eratosthenes algorithm. Each
 * iteration reconstructs the sieve array and repeatedly
 * marks composite numbers. (multiples)
 * The workload stresses the VM with tight integer loops,
 * heavy array indexing, and frequent conditional branches.
 * Its purpose is to measure raw loop efficiency and memory
 * access performance under sustained iteration, while
 * remaining deterministic and easy to verify with a checksum.
 */

function sieveOfEratosthenes(N) {
    marking_arr = new();

    prime_checksum = 0;
    prime_counter = 0;
    prime_arr = new();

    i = 0;
    while (i < N) { marking_arr[i] = false; i = i + 1; }

    marking_arr[0] = true;    // The num 0 isn't a prime.
    marking_arr[1] = true;    // The num 1 isn't a prime.

    i = 0;
    while (i < N) {
        if (marking_arr[i] == false) {
            prime_arr[prime_counter] = i;
            prime_counter = prime_counter + 1;
            prime_checksum = prime_checksum + i;

            j = 2 * i;
            while (j < N) {
                marking_arr[j] = true;
                j = j + i;
            }
        }

        i = i + 1;
    }

    bundle_result = new();
    bundle_result.prime_arr = prime_arr;
    bundle_result.checksum = prime_checksum;
    bundle_result.prime_num = prime_counter;

    return bundle_result;
}

function benchmark(N, expect) {
    sieve = sieveOfEratosthenes(N);
    result = false;

    // For speeding up the benchmark I will be making only
    // comparison base on the checksum, for being accurate
    // we should also check the `sieve.prime_arr` to check
    // if the values match.
    // if (sieve.prime_arr == expect.arr) {
    //     if (sieve.prime_num = expect.count) {
    //         if (sieve.checksum == expect.checksum) {
    //             result = true
    //         }
    //     }
    // }
    if (sieve.checksum == expect) { result = true; }

    return result;
}

function mod(a, b) {
    return a - (b * (a / b));
}

function nanoToTimestamp(time) {
    millis = time / 1000000;

    hour = (millis / 3600000);
    minutes = mod((millis / 60000), 60);
    seconds = mod((millis / 1000), 60);
    millis = mod(millis, 1000);

    result = "";

    if (hour < 10) { result = result + 0; }
    result = result + hour + ":";

    if (minutes < 10) { result = result + 0; }
    result = result + minutes + ":";

    if (seconds < 10) { result = result + 0; }
    result = result + seconds + ":";

    if (millis < 100) { result = result + 0; }
    if (millis < 10) { result = result + 0; }
    result = result + millis;

    return result;
}

// pretty pint second-ish times (nanosec to two digit second, e.g. 2.34s)
// Convert nanoseconds to a string like "2.65s" (digits = 1..3)
function nanoToSecond(time, digits) {
    if (digits < 1) { digits = 1; }
    if (digits > 3) { digits = 3; }

    millis = time / 1000000;
    secs = millis / 1000;
    millis = (millis - secs * 1000);

    denom = 1;
    k = 0;
    while (k < (3 - digits)) {
        denom = denom * 10;
        k = k + 1;
    }

    frac = millis / denom;

    result = "" + secs + ".";
    if (digits == 3) {
        if (frac < 100) { result = result + "0"; }
        if (frac < 10)  { result = result + "0"; }
    }
    if (digits == 2) {
        if (frac < 10)  { result = result + "0"; }
    }
    result = result + frac;
    return result;
}

function main() {
    // Benchmark constants
    NAME = "Sieve of Eratosthenes";
    SEARCH_N = 100000;
    ITERATIONS = 100;
    START_FROM = (ITERATIONS * 8) / 10;
    EXPECTED_CHECKSUM = 454396537;

    // Measurements
    delta_times = new();
    times = new();
    times[0] = nanoTime();

    i = 0;
    while (i < ITERATIONS) {
        t0 = nanoTime();
        // println(nanoToTimestamp(t0) + " > Starting benchmark... [" + (i + 1) + "/" + ITERATIONS + "]");

        result = benchmark(SEARCH_N, EXPECTED_CHECKSUM);

        t1 = nanoTime();
        // println(nanoToTimestamp(nanoTime()) + " > DONE! [" + nanoToSecond(t1 - t0, 2) + "s]");
        times[i + 1] = t1;
        if (i >= START_FROM) {
            delta_times[i - START_FROM] = t1 - t0;
        }
        i = i + 1;
    }

    // Calculations based on them
    delta_et = times[ITERATIONS] - times[0];
    elapsed_time = nanoToSecond(delta_et, 3);

    delta_wt = times[START_FROM] - times[0];
    warmup_time = nanoToSecond(delta_wt, 3);

    avg_it = 0;
    max_it = 0;
    min_it = 100000000000000000000000000000000000000000000000000000000000000000;

    i = 0;
    while (i < getSize(delta_times)) {
        curr = delta_times[i];

        avg_it = avg_it + curr;
        if (curr > max_it) { max_it = curr; }
        if (curr < min_it) { min_it = curr; }

        i = i + 1;
    }
    avg_it = avg_it / getSize(delta_times);

    // Print results
    println("---- " + NAME + " ----");
    println("Total Elapsed Time: " + elapsed_time + "s");
    println("Warm Up Time: " + warmup_time + "s");
    println("Average Iteration Time: " + nanoToSecond(avg_it, 3) + "s");
    println("Max Iteration Time: " + nanoToSecond(max_it, 3) + "s");
    println("Min Iteration Time: " + nanoToSecond(min_it, 3) + "s");
}