/* EqualityAndCoercion.sl                            [strings]
 *
 * This unit tests will assert that:
 *  - Numeric-to-string concatenation does not imply equality,
 *    even more, there's no truthy or falsy in SL.
 *  - 0 == "0" is false; equality is not cross-type-coercive.
 *  - It does not exist the strict equality in SL.
 */
function main() {
  println(0 == "0");                        // false
  println(42 == "42");                      // false
  println("42" == "42");                    // true

  // println(typeOf(0 + "") == 'String');   // Error(s) parsing script :( (seems like you can't do op with types)
  val = 0 + "";
  println(val);                             // 0
  // println(val == "0")                    // Error(s) parsing script :( (seems like something wrong with reference-impl)

  // println(0 === 0);                      //  Error(s) parsing script :(

  println("num=" + 7);                      // num=7
  println(7 + "7");                         // 77
  println((7 + 7) + "");                    // 14
  println("" + 7 + 7);                      // 77
}
