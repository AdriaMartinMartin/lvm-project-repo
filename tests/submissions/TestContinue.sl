// "other" tests

function main() {
  i = 0;
  sum = 0;
  while (i < 10) {
    i = i + 1;
    if ((i / 2) * 2 == i) {
      continue;
    }
    sum = sum + i;
    println("i: " + i + ", current sum: " + sum);
  }
  println("Final sum of odd numbers: " + sum);
}
