/* MatrixOperations.sl                                 [computations]
 *
 * Tests nested-array matrices:
 *   - 3×3 addition, subtraction, and multiplication (“dot product”).
 *   - 3-D vector cross product (using row 0 of each matrix).
 *   - Pretty-print in pipe-delimited format.
 */

function matStructure() {
    mat = new();

    i = 0;
    while (i < 3) { mat[i] = new(); i = i + 1; }

    return mat;
}

function matrixInitializer() {
    matA = matStructure();
    matB = matStructure();

    i = 0;
    j = 0;
    while (i < 3) {
        matA[i][j] = i*3 + j + 1;
        matB[i][j] = 9 - j - i*3;
        j = j + 1;

        if (j == 3) {
            j = 0;
            i = i + 1;
        }
    }

    bundle = new();
    bundle.A = matA;
    bundle.B = matB;

    return bundle;
}

function matrixAdd(A, B) {
    C = matStructure();

    i = 0;
    j = 0;
    while (i < 3) {
        C[i][j] = A[i][j] + B[i][j];
        j = j + 1;

        if (j == 3) {
            j = 0;
            i = i + 1;
        }
    }

    return C;
}

function dotProduct(A, B) {
    value = 0;

    i = 0;
    j = 0;
    while (i < 3) {
        value = value + (A[i][j] * B[i][j]);
        j = j + 1;

        if (j == 3) {
            j = 0;
            i = i + 1;
        }
    }

    return value;
}


// Pretty-printer
function printMatrix(M) {
    println("| " + M[0][0] + " " + M[0][1] + " " + M[0][2] + " |");
    println("| " + M[1][0] + " " + M[1][1] + " " + M[1][2] + " |");
    println("| " + M[2][0] + " " + M[2][1] + " " + M[2][2] + " |");
}

function main() {
    bundle = matrixInitializer(matA, matB);

    matA = bundle.A;
    matB = bundle.B;

    println("A=");
    printMatrix(matA);
    println("B=");
    printMatrix(matB);

    println("A+B=");
    printMatrix(matrixAdd(matA, matB));
    println("A·B=" + dotProduct(matA, matB));
}