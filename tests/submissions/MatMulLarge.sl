/*
 * COMPUTATION: Larger 3x3 Matrix Multiplication
 */

function main() {
  // A = [[1,2,3], [4,5,6], [7,8,9]]
  A = new();
  i = 0;
  while (i < 3) {
    A[i] = new();
    i = i + 1;
  }
  A[0][0] = 1; A[0][1] = 2; A[0][2] = 3;
  A[1][0] = 4; A[1][1] = 5; A[1][2] = 6;
  A[2][0] = 7; A[2][1] = 8; A[2][2] = 9;

  // B = [[9,8,7], [6,5,4], [3,2,1]]
  B = new();
  i = 0;
  while (i < 3) {
    B[i] = new();
    i = i + 1;
  }
  B[0][0] = 9; B[0][1] = 8; B[0][2] = 7;
  B[1][0] = 6; B[1][1] = 5; B[1][2] = 4;
  B[2][0] = 3; B[2][1] = 2; B[2][2] = 1;

  // C = A * B
  C = new();
  i = 0;
  while (i < 3) {
    C[i] = new();

    j = 0;
    while (j < 3) {
      C[i][j] = 0;

      k = 0;
      while (k < 3) {
        C[i][j] = C[i][j] + A[i][k] * B[k][j];
        k = k + 1;
      }
      println(C[i][j]);

      j = j + 1;
    }

    i = i + 1;
  }
}
