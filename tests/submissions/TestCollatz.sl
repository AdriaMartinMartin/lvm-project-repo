// "computations" tests
// Performs a simple mathematical sequence computation (Collatz conjecture).

function collatz_steps(n) {
  if (n <= 0) {
    return 0;
  }
  steps = 0;
  while (n != 1) {
    if ((n / 2) * 2 == n) {
      n = n / 2;
    } else {
      n = 3 * n + 1;
    }
    steps = steps + 1;
  }
  return steps;
}

function main() {
  // Test with a known value
  n = 6;
  steps = collatz_steps(n);
  println("Steps for " + n + ": " + steps);
  if (steps != 8) {
    println("Assertion failed for n=6");
  }

  n = 12;
  steps = collatz_steps(n);
  println("Steps for " + n + ": " + steps);
  if (steps != 9) {
    println("Assertion failed for n=12");
  }
}
