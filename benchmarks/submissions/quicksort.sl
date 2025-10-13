/*
 * "benchmark" test
 * Test performance: We will use the quicksort algorithm to sort an array and test its performance
 */

// Modulo function
function mod(a, b)
{
  return a - (a / b) * b;
}

// Linear Congruential Generator for random number generation (inspired from internet to get constants a=1664525 c=1013904223 m=4294967296)
function random(seed, max)
{
  next_seed = 1664525 * seed + 1013904223;
  next_seed = mod(next_seed, 4294967296);
  value = mod(next_seed, max);
  retval = new();
  retval.seed = next_seed;
  retval.value = value;
  return retval;
}

// Function to generate a random array of size n
function getRandomArray(length, init_seed, max_value)
{
  arr = new();
  seed = init_seed;
  i = 0;
  while (i < length)
  {
    retval = random(seed, max_value);
    seed = retval.seed;
    arr[i] = retval.value;
    i = i + 1;
  }
  return arr;
}

// sort a partition of the full array
function partition(arr, start, end)
{
  pivot = arr[end];
  i = start - 1;
  j = start;
  while (j < end)
  {
    if (arr[j] < pivot)
    {
      i = i + 1;
      temp = arr[i];    // swap elements i and j 
      arr[i] = arr[j];
      arr[j] = temp;
    }
    j = j + 1;
  }
  i = i + 1;
  temp = arr[i];
  arr[i] = arr[end];
  arr[end] = temp;

  return i;
}

// recursive function for quicksort 
function sort_round(arr, start, end)
{
  if (end <= start)
  {
    return;
  }
  else
  {
    pivot = partition(arr, start, end);
    sort_round(arr, start, pivot - 1);   // first part array
    sort_round(arr, pivot + 1, end);     // second part array
  }
}

// quick sort algorithm function to sort an array
function quicksort(arr)
{
  sort_round(arr, 0, getSize(arr) - 1); // passing the start and end index values
}

// function to print all elements of an array (DEBUG)
function print_array(arr)
{
  i = 0;
  while (i < getSize(arr))
  {
    // println(arr[i]);
    i = i + 1;
  }
}

// run the quick sort algorithm on a array to benchmark
function runBenchmark(size)
{
  // get a random array of length, seed, and max value
  arr = getRandomArray(size, 42, 100000);
  // println("Array Unsorted:");
  // print_array(arr);

  sorted_arr = quicksort(arr);
  // println("Array Sorted:");
  // print_array(arr);
}

// Main function
function main()
{
  array_size = 1000;
  total_iterations = 10000;
  measured_from = 8000;
  name = "QUICK SORT";

  iterations = 0;
  time = 0;

  while (iterations < total_iterations)
  {
    t_start = nanoTime();
    runBenchmark(array_size);
    t_end = nanoTime() - t_start;
    if (iterations >= measured_from)
    {
      time = time + t_end;
    }
    iterations = iterations + 1;
  }

  avg = time / (total_iterations - measured_from);
  println(name + ": " + avg);
  
}
