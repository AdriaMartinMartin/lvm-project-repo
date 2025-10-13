// Make array of length len, filled with 0
function makeZeros(len) {
  a = new();
  i = 0;
  while (i < len) { a[i] = 0; i = i + 1; }
  return a;
}

// Deep-copy cols[0..n-1]
function copyCols(cols, n) {
  c = new();
  i = 0;
  while (i < n) { c[i] = cols[i]; i = i + 1; }
  return c;
}

// Push a copy of cols into solutions
function pushSolution(solutions, cols, n) {
  c = copyCols(cols, n);
  solutions[getSize(solutions)] = c;
  return 0;
}

// O(1) safe check using occupancy tables
function isSafeFast(row, col, usedCol, usedD1, usedD2, n) {
  idxD1 = row - col + (n - 1);  
  idxD2 = row + col;
  if (usedCol[col] == 0 && usedD1[idxD1] == 0 && usedD2[idxD2] == 0) { return 1; }
  return 0;
}

// Place/remove queen (mark/unmark)
function place(row, col, usedCol, usedD1, usedD2, n, val) {
  usedCol[col] = val;
  usedD1[row - col + (n - 1)] = val;
  usedD2[row + col] = val;
  return 0;
}

// Backtracking on columns (no 2D board)
function solveCols(row, n, cols, usedCol, usedD1, usedD2, solutions) {
  if (row == n) { pushSolution(solutions, cols, n); return 0; }
  col = 0;
  while (col < n) {
    if (isSafeFast(row, col, usedCol, usedD1, usedD2, n) == 1) {
      cols[row] = col;
      place(row, col, usedCol, usedD1, usedD2, n, 1);
      solveCols(row + 1, n, cols, usedCol, usedD1, usedD2, solutions);
      place(row, col, usedCol, usedD1, usedD2, n, 0);
    }
    col = col + 1;
  }
  return 0;
}

//Validate one solution in O(n): each row has exactly one queen, and no two queens share a column / main diag / anti diag.
function validateSolution(cols, n) {
  usedC  = makeZeros(n);
  usedD1 = makeZeros(2 * n - 1);  
  usedD2 = makeZeros(2 * n - 1); 

  r = 0;
  while (r < n) {
    c = cols[r];

    if (usedC[c] == 1) { println("FAIL: dup col at row " + r); }
    usedC[c] = 1;

    if (usedD1[r - c + (n - 1)] == 1) { println("FAIL: dup d1 at row " + r); }
    usedD1[r - c + (n - 1)] = 1;


    if (usedD2[r + c] == 1) { println("FAIL: dup d2 at row " + r); }
    usedD2[r + c] = 1;

    r = r + 1;
  }
  return 0;
}

// Pretty-print one solution (convert cols -> lines of '.' and 'Q')
function printSolution(cols, n) {
  r = 0;
  while (r < n) {
    line = "";
    c = 0;
    while (c < n) {
      if (c == cols[r]) { line = line + "Q"; } else { line = line + "."; }
      c = c + 1;
    }
    // println(line);
    r = r + 1;
  }
  return 0;
}

// Wrapper: solves and optionally prints first solution
function nQueensCols(n, printYes) {
  cols    = makeZeros(n);
  usedCol = makeZeros(n);
  usedD1  = makeZeros(2 * n - 1);   // 0..2n-2
  usedD2  = makeZeros(2 * n - 1);

  solutions = new();
  solveCols(0, n, cols, usedCol, usedD1, usedD2, solutions);

  if (printYes) {
    // println("Number of sols: " + getSize(solutions));
    if (getSize(solutions) > 0) { 
      first = solutions[0];
      validateSolution(first, n);

      printSolution(solutions[0], n); }
  }
  return solutions;  // caller may check size for assertions
}

// ---- benchmark workload: run k times per iteration ----
function benchOnce(n, k) {
  t = 0;
  while (t < k) {
    sols = nQueensCols(n, false);
    // correctness assertions for known sizes
    if (n == 7) {
      if (getSize(sols) != 40) { println("FAIL: expected 40 solutions for n=7"); }
    }
    if (n == 8) {
      if (getSize(sols) != 92) { println("FAIL: expected 92 solutions for n=8"); }
    }
    t = t + 1;
  }
  return 0;
}

function main() {
  NAME = "N-Queens-Cols";
  N = 8;      
  K = 20;     

  ITERATIONS   = 600;
  MEASURE_FROM = (ITERATIONS * 4) / 5;   // 80% 热身

  time = 0;
  it = 0;
  while (it < ITERATIONS) {
    s = nanoTime();
    benchOnce(N, K);
    e = nanoTime() - s;
    if (it >= MEASURE_FROM) { time = time + e; }
    it = it + 1;
  }

  avg = time / (ITERATIONS - MEASURE_FROM);
  println(NAME + ": " + avg);
}
