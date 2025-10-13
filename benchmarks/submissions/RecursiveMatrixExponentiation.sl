function createMatrix(){
    matrix = new();

    matrix[0] = new();
    matrix[1] = new();
    matrix[2] = new();
    matrix[3] = new();
    matrix[4] = new();

    matrix[0][0] = 2;
    matrix[0][1] = 4;
    matrix[0][2] = 2;
    matrix[0][3] = 10;
    matrix[0][4] = 4;

    matrix[1][0] = 3;
    matrix[1][1] = 4;
    matrix[1][2] = 10;
    matrix[1][3] = 4;
    matrix[1][4] = 2;

    matrix[2][0] = 1;
    matrix[2][1] = 4;
    matrix[2][2] = 6;
    matrix[2][3] = 6;
    matrix[2][4] = 1;

    matrix[3][0] = 7;
    matrix[3][1] = 1;
    matrix[3][2] = 6;
    matrix[3][3] = 6;
    matrix[3][4] = 1;

    matrix[4][0] = 8;
    matrix[4][1] = 9;
    matrix[4][2] = 9;
    matrix[4][3] = 1;
    matrix[4][4] = 6;

    return matrix;
}

function matrixMultiply(first, second) {
    resultMatrix = new();
    resultMatrix[0] = new();
    resultMatrix[1] = new();
    resultMatrix[2] = new();
    resultMatrix[3] = new();
    resultMatrix[4] = new();

    row = 0;
    while (row < getSize(first)) {
        column = 0;
        while (column < getSize(second[0])) {
            resultMatrix[row][column] = 0;
            i = 0;
            while(i< getSize(first[0])) {
                resultMatrix[row][column] = resultMatrix[row][column] + first[row][i]*second[i][column];
                i = i + 1;
            }
            column = column + 1;
        }
        row = row + 1;
    }
    return resultMatrix;
}


// N is original matrix or could be identity but then k==0 in recursion.
function matrixPowerExponentiate(M, N, k) {
    if (k == 1) {
        return M;
    } else {
        return matrixPowerExponentiate(matrixMultiply(M, N),N, k-1);
    }
}

// Computes the determinant of a square matrix using Laplace expansion
function matrixDeterminant(matrix) {
    size = getSize(matrix);

    // Base cases
    if (size == 1) {
        return matrix[0][0];
    }
    if (size == 2) {
        return matrix[0][0] * matrix[1][1] - matrix[0][1] * matrix[1][0];
    }

    det = 0;
    col = 0;

    while (col < size) {
        subMatrix = new();
        rowIndex = 0;
        while (rowIndex < size - 1) {
            subMatrix[rowIndex] = new();
            rowIndex = rowIndex + 1;
        }

        i = 1;
        subRow = 0;
        while (i < size) {
            j = 0;
            subCol = 0;
            while (j < size) {
                if (j != col) {
                    subMatrix[subRow][subCol] = matrix[i][j];
                    subCol = subCol + 1;
                }
                j = j + 1;
            }
            subRow = subRow + 1;
            i = i + 1;
        }

        sign = 1;
        k = col;
        while (k > 0) {
            sign = sign * -1;
            k = k - 1;
        }

        det = det + sign * matrix[0][col] * matrixDeterminant(subMatrix);
        col = col + 1;
    }

    return det;
}

// We define a 5x5 matrix M and compute M^64 using an inefficient recursive method and an O(n^3) matrix mul alg. We then take the determinant
// of the result matrix and make sure that indeed det(M)^64 = det(M^64).
function benchmark() {

  matrix = createMatrix();
  resultMatrix = matrixPowerExponentiate(matrix, matrix, 64);
  resultDeterminant = matrixDeterminant(resultMatrix);
  expectedDeterminant = 6651450753432238120592792096296377056195839896548059215408668491988570492106119605733017783266194076050099804052336227955177228085955388338820200505085853998998592095206557288143704878937126596133110038522800646327434714274215323693148253229940736;
  //
  // Test that the benchmark result is correct (MODIFY THIS)
  //
  if (resultDeterminant != expectedDeterminant) {
    println("Benchmark failed!");
  }
}

function main() {
  //
  // benchmark constants
  //
  ITERATIONS = 10000;
  MEASURE_FROM = 8000;
  NAME = "Matrix Recursive Exponentiation And Determinant Calculation";

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
