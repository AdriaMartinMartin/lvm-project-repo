/* ConcatenationPrecedence.sl              [strings]
 *
 * This unit tests asserts that:
 *  - "+" concatenates when a string is involved.
 *  - Left-to-right evaluation matters.
 *  - Parentheses control numeric vs string outcomes.
 */
function main() {
  println("a" + "b");          // ab
  println("a" + 1);            // a1
  println(1 + "a");            // 1a

  println("" + 2 + 3);         // 23      (left-to-right concatenation)
  println(2 + 3 + "");         // 5       (2+3 first, then to string)
  println("" + (2 + 3));       // 5

  println("x:" + (1 + 2*3));   // x:7     (parentheses + precedence)
  println(("x:" + 1) + 2*3);   // x:16    ("x:1" + 6)
}