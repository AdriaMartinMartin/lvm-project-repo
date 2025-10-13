/*
 * Sudoku Solver Benchmark
 * Solves a fixed 9x9 Sudoku puzzle using backtracking
 */

function createBoard() {
    board = new();
    i = 0;
    while (i < 9) {
        row = new();
        j = 0;
        while (j < 9) {
            row[j] = 0;
            j = j + 1;
        }
        board[i] = row;
        i = i + 1;
    }
    return board;
}

function copyBoard(src) {
    dest = new();
    i = 0;
    while (i < 9) {
        dest[i] = new();
        j = 0;
        while (j < 9) {
            dest[i][j] = src[i][j];
            j = j + 1;
        }
        i = i + 1;
    }
    return dest;
}

function isSafe(board, row, col, num) {
    i = 0;
    while (i < 9) {
        if (board[row][i] == num) {
            return 0;
        } 
        if (board[i][col] == num) {
            return 0;
        } 
        i = i + 1;
    }

    startRow = row;
    
    startCol = col;
    
    if (row < 3) {
        startRow = 0;
    } else {
        if (row < 6) {
            startRow = 3;
        } else {
            startRow = 6;
        }
    }

    if (col < 3) {
        startCol = 0;
    } else {
        if (col < 6) {
            startCol = 3;
        } else {
            startCol = 6;
        }
    }

    i = 0;
    while (i < 3) {
        j = 0;
        while (j < 3) {
            if (board[startRow + i][startCol + j] == num) {
                return 0;
            } 
            j = j + 1;
        }
        i = i + 1;
    }
    return 1;
}

function solveSudoku(board) {
    row = 0;
    col = 0;
    foundEmpty = 0;

    i = 0;
    while (i < 9 && foundEmpty == 0) {
        j = 0;
        while (j < 9 && foundEmpty == 0) {
            if (board[i][j] == 0) {
                row = i;
                col = j;
                foundEmpty = 1;
            } 
            j = j + 1;
        }
        i = i + 1;
    }

    if (foundEmpty == 0) {
        return 1;
    }

    num = 1;
    while (num <= 9) {
        if (isSafe(board, row, col, num) == 1) {
            board[row][col] = num;
            if (solveSudoku(board) == 1) {
                return 1;
            } else {
                board[row][col] = 0;
            }
        } 
        num = num + 1;
    }
    return 0;
}

function checkSolution(board) {
    row = 0;
    while (row < 9) {
        numbers = new();
        i = 1;
        while (i <= 9) {
            numbers[i] = 0;
            i = i + 1;
        }

        col = 0;
        while (col < 9) {
            num = board[row][col];
            if (num < 1 || num > 9 || numbers[num] == 1) {
                println("ERROR: Duplicate or invalid number " + num + " in row " + row);
            } else {
                numbers[num] = 1;
            }
            col = col + 1;
        }
        row = row + 1;
    }

    col = 0;
    while (col < 9) {
        numbers = new();
        i = 1;
        while (i <= 9) {
            numbers[i] = 0;
            i = i + 1;
        }

        row = 0;
        while (row < 9) {
            num = board[row][col];
            if (num < 1 || num > 9 || numbers[num] == 1) {
                println("ERROR: Duplicate or invalid number " + num + " in column " + col);
            } else {
                numbers[num] = 1;
            }
            row = row + 1;
        }
        col = col + 1;
    }

    blockRow = 0;
    while (blockRow < 9) {
        blockCol = 0;
        while (blockCol < 9) {
            numbers = new();
            i = 1;
            while (i <= 9) {
                numbers[i] = 0;
                i = i + 1;
            }

            i = 0;
            while (i < 3) {
                j = 0;
                while (j < 3) {
                    num = board[blockRow + i][blockCol + j];
                    if (num < 1 || num > 9 || numbers[num] == 1) {
                        println("ERROR: Duplicate or invalid number " + num + " in 3x3 block starting at " + blockRow + "," + blockCol);
                    } else {
                        numbers[num] = 1;
                    }
                    j = j + 1;
                }
                i = i + 1;
            }
            blockCol = blockCol + 3;
        }
        blockRow = blockRow + 3;
    }
}


function benchmark() {
    puzzle = createBoard();

    puzzle[0][2] = 4; 
    puzzle[0][8] = 2; 
    puzzle[1][0] = 8; 
    puzzle[1][4] = 2; 
    puzzle[1][6] = 5; 
    puzzle[1][7] = 9; 
    puzzle[2][1] = 5; 
    puzzle[2][3] = 7; 
    puzzle[3][1] = 4; 
    puzzle[3][2] = 9; 
    puzzle[4][0] = 6; 
    puzzle[4][4] = 7; 
    puzzle[4][6] = 1; 
    puzzle[4][8] = 8; 
    puzzle[5][1] = 1; 
    puzzle[5][6] = 9; 
    puzzle[5][8] = 5; 
    puzzle[6][2] = 2; 
    puzzle[6][3] = 6; 
    puzzle[6][5] = 4; 
    puzzle[6][7] = 7; 
    puzzle[7][1] = 8; 
    puzzle[7][2] = 6; 
    puzzle[7][8] = 1; 
    puzzle[8][5] = 2; 
    puzzle[8][6] = 6;

    board = copyBoard(puzzle);

    solved = solveSudoku(board);

    if (solved == 0) {
        println("Benchmark failed! Could not solve puzzle.");
    }

    checkSolution(board);
}

function main() {
  //
  // benchmark constants
  //
  ITERATIONS = 400;
  MEASURE_FROM = 320;
  NAME = "Sudoku Solver";

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
    } else {
      // nothing
    }
    it = it + 1;
  }

  avg = time / (ITERATIONS - MEASURE_FROM);
  // Make sure you print the final result -- and no other things!
  println(NAME + ": " + avg);
}



