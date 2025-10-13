// Computation test: Greatest Common Divisor algorithm
function main() {
  // Test basic GCD cases
  println(gcd(48, 18));
  println(gcd(100, 25));
  println(gcd(17, 13));
  println(gcd(54, 24));
  
  // Test edge cases
  println(gcd(0, 5));
  println(gcd(7, 0));
  println(gcd(1, 1));
  println(gcd(1, 100));
  
  // Test identical numbers
  println(gcd(15, 15));
  println(gcd(42, 42));
  
  // Test larger numbers
  println(gcd(1071, 462));
  println(gcd(270, 192));
  
  // Test prime numbers
  println(gcd(29, 31));
  println(gcd(19, 23));
  
  // Test multiple GCD calculations
  a = 84;
  b = 36;
  result1 = gcd(a, b);
  println(result1);
  
  c = 144;
  d = 60;
  result2 = gcd(c, d);
  println(result2);
  
  // Test GCD properties
  x = 12;
  y = 18;
  gcdXY = gcd(x, y);
  println(gcdXY);
  println(gcd(y, x)); // Should be same as gcd(x, y)
  
  // Test with computed values
  val1 = 15 * 7;
  val2 = 15 * 11;
  println(gcd(val1, val2));
  
  // Test series of GCD calculations
  println(gcd(gcd(24, 36), 48));
}

function gcd(a, b) {
  // Handle edge cases
  if (a == 0) {
    return b;
  }
  if (b == 0) {
    return a;
  }
  
  // Ensure positive values
  if (a < 0) {
    a = 0 - a;
  }
  if (b < 0) {
    b = 0 - b;
  }
  
  // Euclidean algorithm using subtraction method
  while (a != b) {
    if (a > b) {
      a = a - b;
    } else {
      b = b - a;
    }
  }
  return a;
}
