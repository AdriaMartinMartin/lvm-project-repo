// Matrix multiplication benchmark: dense linear algebra workload

function createSequentialMatrix(size) {
  matrix = new();
  i = 0;
  while (i < size) {
    row = new();
    j = 0;
    while (j < size) {
      row[j] = i * size + j + 1;
      j = j + 1;
    }
    matrix[i] = row;
    i = i + 1;
  }
  return matrix;
}

function createHilbertMatrix(size) {
  matrix = new();
  i = 0;
  while (i < size) {
    row = new();
    j = 0;
    while (j < size) {
      row[j] = 1 / (i + j + 1);
      j = j + 1;
    }
    matrix[i] = row;
    i = i + 1;
  }
  return matrix;
}

function createTridiagonalMatrix(size) {
  matrix = new();
  i = 0;
  while (i < size) {
    row = new();
    j = 0;
    while (j < size) {
      if (i == j) {
        row[j] = 2;
      } else {
        if (i == j + 1 || j == i + 1) {
          row[j] = 1;
        } else {
          row[j] = 0;
        }
      }
      j = j + 1;
    }
    matrix[i] = row;
    i = i + 1;
  }
  return matrix;
}

function multiplyMatrices(a, b, size) {
  result = new();
  i = 0;
  while (i < size) {
    row = new();
    j = 0;
    while (j < size) {
      sum = 0;
      k = 0;
      while (k < size) {
        sum = sum + a[i][k] * b[k][j];
        k = k + 1;
      }
      row[j] = sum;
      j = j + 1;
    }
    result[i] = row;
    i = i + 1;
  }
  return result;
}

function matrixPower(matrix, size, n) {
  if (n == 1) {
    return matrix;
  }
  
  result = matrix;
  power = 1;
  while (power < n) {
    result = multiplyMatrices(result, matrix, size);
    power = power + 1;
  }
  return result;
}

function matrixTrace(matrix, size) {
  trace = 0;
  i = 0;
  while (i < size) {
    trace = trace + matrix[i][i];
    i = i + 1;
  }
  return trace;
}

function matrixSum(matrix, size) {
  sum = 0;
  i = 0;
  while (i < size) {
    j = 0;
    while (j < size) {
      sum = sum + matrix[i][j];
      j = j + 1;
    }
    i = i + 1;
  }
  return sum;
}

function copyMatrix(matrix, size) {
  result = new();
  i = 0;
  while (i < size) {
    row = new();
    j = 0;
    while (j < size) {
      row[j] = matrix[i][j];
      j = j + 1;
    }
    result[i] = row;
    i = i + 1;
  }
  return result;
}

function computeMatrixNorm(matrix, size) {
  sumSquares = 0;
  i = 0;
  while (i < size) {
    j = 0;
    while (j < size) {
      value = matrix[i][j];
      sumSquares = sumSquares + value * value;
      j = j + 1;
    }
    i = i + 1;
  }
  return sumSquares;
}

function validateResults(trace, norm) {
  if (trace < 0 || norm < 0) {
    println("Benchmark failed: negative result");
    return false;
  }
  
  if (trace == 0 && norm == 0) {
    println("Benchmark failed: zero result");
    return false;
  }
  
  return true;
}

function benchmark() {
  SIZE = 32;
  
  sequential = createSequentialMatrix(SIZE);
  hilbert = createHilbertMatrix(SIZE);
  tridiagonal = createTridiagonalMatrix(SIZE);
  
  product1 = multiplyMatrices(sequential, hilbert, SIZE);
  product2 = multiplyMatrices(product1, tridiagonal, SIZE);
  
  cubed = matrixPower(sequential, SIZE, 3);
  
  finalResult = multiplyMatrices(product2, cubed, SIZE);
  
  resultTrace = matrixTrace(finalResult, SIZE);
  resultNorm = computeMatrixNorm(finalResult, SIZE);
  
  validateResults(resultTrace, resultNorm);
}

function main() {
  ITERATIONS = 100;
  MEASURE_FROM = 80;
  NAME = "MatrixMultiply";

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
  println(NAME + ": " + avg);
}
