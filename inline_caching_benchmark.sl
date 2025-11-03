function main() {
    start = nanoTime();

    i = 0;
    limit = 200000;   // Increase this for heavier testing

    while (i < limit) {
        o = new();

        // Create a predictable object shape evolution
        o.a = i;
        o.b = i + 1;
        o.c = i + 2;

        // Access properties multiple times
        x = o.a + o.b + o.c;

        // Change the shape slightly
        o["d"] = x;
        o["a"] = o["a"] + 1;

        // Read again to trigger inline cache hits
        y = o.a + o.b + o.c + o.d;

        i = i + 1;
    }

    end = nanoTime();
    elapsed = (end - start) / 1000000;  // Convert to milliseconds
    println("Elapsed: " + elapsed + " ms for " + limit + " iterations");
}