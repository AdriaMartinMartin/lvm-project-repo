//
// A simple image processing benchmark (integer-based).
//
// This benchmark creates a grid of pixels, applies a simple filter,
// and calculates a checksum to verify correctness.
// It is designed to test object allocation, arithmetic operations, and array access.
//

// A pixel "class"
function newPixel(r, g, b) {
  p = new();
  p.r = r;
  p.g = g;
  p.b = b;
  return p;
}

function pixelToString(p) {
    return "Pixel(" + p.r + ", " + p.g + ", " + p.b + ")";
}

// The benchmark function.
function benchmark() {
  WIDTH = 100;
  HEIGHT = 100;
  SIZE = WIDTH * HEIGHT;

  grid = new();

  // Initialize grid with predictable values.
  i = 0;
  while (i < SIZE) {
    val = i - (256 * (i / 256));
    grid[i] = newPixel(val, val, val);
    i = i + 1;
  }

  // Apply a simple filter (invert colors)
  i = 0;
  while (i < SIZE) {
    p = grid[i];
    p.r = 255 - p.r;
    p.g = 255 - p.g;
    p.b = 255 - p.b;
    i = i + 1;
  }

  // Calculate checksum of red components
  checksum = 0;
  i = 0;
  while (i < SIZE) {
    p = grid[i];
    checksum = checksum + p.r;
    i = i + 1;
  }

  // Expected checksum calculated as:
  // sum(255 - (i - (256 * (i / 256)))) for i from 0 to 9999
  expected_checksum = 1276920;

  // Assertion to verify correctness.
  if (checksum != expected_checksum) {
    println("Benchmark failed: checksum mismatch!");
    println("Expected checksum: " + expected_checksum);
    println("Actual checksum: " + checksum);
    return;
  }
}

function main() {
  //
  // benchmark constants
  //
  ITERATIONS = 200;
  MEASURE_FROM = 160; // 80% warmup
  NAME = "ImageProcessing";

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
