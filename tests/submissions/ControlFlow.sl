// Other test: Control flow with nested loops and break/continue
function main() {
  // Test nested loops with break
  i = 0;
  while (i < 3) {
    j = 0;
    while (j < 4) {
      if (i == 1 && j == 2) {
        println("Break at " + i + "," + j);
        break;
      }
      println(i * 10 + j);
      j = j + 1;
    }
    i = i + 1;
  }
  
  // Test nested loops with continue
  i = 0;
  while (i < 2) {
    j = 0;
    while (j < 3) {
      if (i == 1 && j == 1) {
        j = j + 1;
        continue;
      }
      println(i * 10 + j);
      j = j + 1;
    }
    i = i + 1;
  }
  
  // Test conditionals
  x = 5;
  y = 10;
  if (x < y) {
    if (x > 0) {
      println("Valid");
    } else {
      println("Invalid");
    }
  } else {
    println("Wrong");
  }

  // Test multiple exit conditions
  count = 0;
  sum = 0;
  while (count < 10) {
    sum = sum + count;
    if (sum > 20) {
      break;
    }
    count = count + 1;
  }
  println(sum);
  
  // Test nested if-else
  val = 42;
  if (val < 10) {
    println("Small");
  } else {
    if (val > 40) {
      println("Large");
    } else {
      println("Medium");
    }
  }
  
  // Test loop with functions
  i = 0;
  while (i < 4) {
    if (isEven(i)) {
      println("Even");
    } else {
      println("Odd");
    }
    i = i + 1;
  }
}

function isEven(n) {
  while (n > 1) {
    n = n - 2;
  }
  return n == 0;
}
