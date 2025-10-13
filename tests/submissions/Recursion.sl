/* 
 * Tests other features (recursion)
 */

function factorial(n) {
  if (n == 0){
    return 1;
  } else {
    return n * factorial(n-1);
  }
}

function main() {
  f = factorial(5);
  println(f);
}
