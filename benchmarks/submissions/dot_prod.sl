function dot_prod(n) {
  x = new();
  y = new();

  // Initialize vectors
  index = 0;
  while (index < n) {
    x[index] = index;
    y[index] = n - index;
    index = index + 1;
  }

  // Calculate final dot product
  final_sum = 0;
  index = 0;
  while (index < n) {
    final_sum = final_sum + x[index] * y[index];
    index = index + 1;
  }

  return final_sum;
}

function benchmark() {
  d = dot_prod(100);
  //
  // Test that the benchmark result is correct
  //
  if (d != 166650) {
    println("Benchmark failed!");
  }
}  

function main() {
  //
  // benchmark constants
  //
  ITERATIONS = 200000;
  MEASURE_FROM = 160000;
  NAME = "DotProduct";

  //
  // harness
  //
  time = 0;
  it = 0;

  while (it < ITERATIONS) {
    s = nanoTime();
    benchmark();
    e = nanoTime() - s;
    if (it >= MEASURE_FROM) {
      time = time + e;
    }
    it = it + 1;
  }

  avg = time / (ITERATIONS - MEASURE_FROM);
  // Make sure you print the final result -- and no other things!
  println(NAME + ": " + avg);
}
