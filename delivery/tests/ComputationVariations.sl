/* ComputationVariations.sl        [computations]
 *
 * This unit tests asserts:
 *   - Unary minus vs subtraction
 *   - Operator precedence and parentheses
 *   - Integer-valued divisions
 *   - Left-associativity of subtraction/division
 */
function main() {
    println(-3);                 // -3
    println(0 - 3);              // -3
    println(-(-3));              // 3
    println(-(-(-5)));           // -5

    println(1 + 2 * 3);          // 7
    println((1 + 2) * 3);        // 9
    println(10 - 2 * 4);         // 2
    println((10 - 2) * 4);       // 32

    println(10 - 3 - 2);         // 5
    println(10 - (3 - 2));       // 9

    println(6 / 3);              // 2
    println(8 / 4);              // 2
    println(9 / 3);              // 3
    println(0 / 5);              // 0

    println((-6) / 3);           // -2
    println(6 / (-3));           // -2
    println((-6) / (-3));        // 2

    println(24 / 3 / 2);         // 4
    println(24 / (3 / 2));       // 24 (truncates instead of rounding)

    println((1 - 2) - 3);        // -4
    println(1 - (2 - 3));        // 2
    println((4 - (2 - 1)) * 3);  // 9

    println(-(2 + 3) * 4);       // -20
    println(-2 + 3 * 4);         // 10
    println((-2 + 3) * 4);       // 4

    println((12 / 3) + (18 / 6) - (20 / 5));  // 4 + 3 - 4 = 3
}