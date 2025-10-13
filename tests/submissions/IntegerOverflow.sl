/*
 * Test Type: computations
 */

function main() {
    i = 1;
    base = 2;
    exp = 31;
    counter = 0;
    while (counter < exp) {
        i = i * base;
        counter = counter + 1;
    }
    println("2^31 = " + i);
    println("2^31 + 1 - 1 = " + (i + 1 - 1));
}