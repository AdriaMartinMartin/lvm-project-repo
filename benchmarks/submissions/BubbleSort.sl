
function sort(arr, x) {
	i = 0;
	while (i < x) {
		if (arr[i] > arr[i+1]) {
			tmp = arr[i+1];
			arr[i+1] = arr[i];
			arr[i] = tmp;
		}
		i = i + 1;
	}
	if (x > 1) {sort(arr, x-1);}
}


function benchmark() {
	TARGET = 100;

	arr = new();
	i = 0;
	while (i < TARGET) {
		arr[i] = TARGET - i;
		i = i + 1;
	}
	sort(arr, TARGET-1);
	i = 0;
	while (i < TARGET) {
		if (arr[i] != i + 1) {println("FAILED!");}
		i = i + 1;
	}
}  


function main() {
  //
  // benchmark constants
  //
  ITERATIONS = 10000;
  MEASURE_FROM = 8000;
  NAME = "BubbleSort";

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
