function createReverseSortedArray(number)
{
  arr = new();
  i = 0;
  while (i < number) {
    arr[i] = number - i;
     i = i + 1;
  }

  return arr;
}

function insertionSort(arr) {
  n = getSize(arr);
  i = 1;
  while (i < n) {
    key = arr[i];
    j = i - 1;

    while (j >= 0 && arr[j] > key) {
      arr[j + 1] = arr[j];
      j = j - 1;
    }
    arr[j + 1] = key;

    i = i + 1;
  }
  return arr;
}

// Array in reversed order
// Input: n = 256 -> approx. 41 seconds
// Input: n = 200 -> approx. 34 seconds
// Input: n = 128 -> approx. 13 seconds
// Input: n = 100 -> approx. 9 seconds

function benchmark() {
  arr = createReverseSortedArray(100);
  result = insertionSort(arr);
  //
  // Test that the benchmark result is correct
  //
  i = 1;
  while( i < getSize(result))
  {
    if(result[i] < result[i-1])
    {
      println("Benchmark failed!");
    }
    i = i + 1;
  }
}

function main() {
  // benchmark constants
  ITERATIONS = 10000;
  MEASURE_FROM = 8000;
  NAME = "InsertionSort";

  // harness
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
  // print only the final result
  println(NAME + ": " + avg);
}
