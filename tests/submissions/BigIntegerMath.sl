// CATEGORY: computations

function main() {
  big1 = 123456789012345678901234567890;
  big2 = 987654321098765432109876543210;
  
  println(big1 + big2);
  println(big2 - big1);
  println(big1 * 2);
  
  small = 42;
  println(big1 + small);
  println(small * big1);
  
  result = big1 + big2 + small;
  println(result);
  
  if (big1 < big2) {
    println("true");
  }
  
  if (big1 == big1) {
    println("equal");
  }
  
  if (big1 + 0 != big1) {
    println("ERROR: addition identity failed");
  }
}
