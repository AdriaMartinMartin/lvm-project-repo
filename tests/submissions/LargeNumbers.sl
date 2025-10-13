// "computations" test.

// Test calculation of big numbers.

function main() {
    // Test common integer overflows as a precondition of the calculations.
    println(8 + 1);
    println(127 + 1);
    println(255 + 1);
    println(32767 + 1);
    println(65535 + 1);
    println(2147483647 + 1);
    println(4294967295 + 1);
    println(9223372036854775807 + 1);
    println(18446744073709551615 + 1);

    // Test multiplying large numbers.
    println(18446744073709551615 * 13);
    println(18446744073709551615 * 4294967295);

    // Test dividing large numbers.
    println((18446744073709551615 * 3) / 13);
    println((18446744073709551615 * 3) / 5);
    println((18446744073709551615 * 3) / 4294967295);
}
