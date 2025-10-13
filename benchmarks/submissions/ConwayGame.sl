/*
 * Conway's Game of Life Benchmark
 *
 * Does a configurable number of steps with an initial so-called
 * "blinker pattern" in the center of a grid which alternates perpetually
 *
 *    . . .  ->  . X .
 *    X X X      . X .
 *    . . .  <-  . X .
 *
 * This highly predictable pattern gives us an easily verifiable output
 * (and intermediate steps) to test against the expected behavior
 *
 * Grids are implemented with objects so this heavily tests object creation & logic
 */

function createGrid(width, height) {
    grid = new();
    grid.width = width;
    grid.height = height;
    grid.cells = new();
    
    // Initialize all cells to 0 (dead)
    i = 0;
    while (i < height) {
        row = new();
        j = 0;
        while (j < width) {
            row[j] = 0;
            j = j + 1;
        }
        grid.cells[i] = row;
        i = i + 1;
    }
    
    return grid;
}

function getCell(grid, x, y) {
    // Out-of-bounds = dead = 0
    if ((x < 0 || y < 0) || (x >= grid.width || y >= grid.height)) {
        return 0;
    }
    return grid.cells[y][x];
}

function setCell(grid, x, y, value) {
    if ((x >= 0 && y >= 0) && (x < grid.width && y < grid.height)) {
        grid.cells[y][x] = value;
    }
}

function countNeighbors(grid, x, y) {
    count = 0;
    
    // Check all 8 neighbors, this is more line efficient
    // than looping over offsets (I checked)
    count = count + getCell(grid, x - 1, y - 1);
    count = count + getCell(grid, x, y - 1);
    count = count + getCell(grid, x + 1, y - 1);
    count = count + getCell(grid, x - 1, y);
    count = count + getCell(grid, x + 1, y);
    count = count + getCell(grid, x - 1, y + 1);
    count = count + getCell(grid, x, y + 1);
    count = count + getCell(grid, x + 1, y + 1);
    
    return count;
}

function stepGrid(grid) {
    // Create new grid for next generation
    newGrid = createGrid(grid.width, grid.height);
    
    y = 0;
    while (y < grid.height) {
        x = 0;
        while (x < grid.width) {
            currentCell = getCell(grid, x, y);
            neighbors = countNeighbors(grid, x, y);
            
            newValue = 0;
            // Default dead unless...
            if (currentCell == 1) {
                // ...live cell with 2-3 neighbors or...
                if (neighbors == 2) { newValue = 1; }
                if (neighbors == 3) { newValue = 1; }
            } else {
                // ...dead cell with exactly 3 neighbors
                if (neighbors == 3) { newValue = 1; }
            }
            
            setCell(newGrid, x, y, newValue);
            x = x + 1;
        }
        y = y + 1;
    }
    
    return newGrid;
}

function setupVerticalBlinker(grid) {
    // Create a vertical blinker pattern in the center of the given grid
    // Integer division (scawy)
    centerX = grid.width / 2;
    centerY = grid.height / 2;
    
    setCell(grid, centerX, centerY - 1, 1);
    setCell(grid, centerX, centerY, 1);
    setCell(grid, centerX, centerY + 1, 1);
}

function checkBlinkerVertical(grid) {
    // Check if blinker is in vertical position
    centerX = grid.width / 2;
    centerY = grid.height / 2;

    // Check vertical line is there
    if (getCell(grid, centerX, centerY - 1) != 1) { return 0; }
    if (getCell(grid, centerX, centerY) != 1) { return 0; }
    if (getCell(grid, centerX, centerY + 1) != 1) { return 0; }
    
    // Check surrounding cells are dead
    if (getCell(grid, centerX - 1, centerY) != 0) { return 0; }
    if (getCell(grid, centerX + 1, centerY) != 0) { return 0; }
    
    return 1;
}

function checkBlinkerHorizontal(grid) {
    // Check if blinker is in horizontal position
    centerX = grid.width / 2;
    centerY = grid.height / 2;
    
    if (getCell(grid, centerX - 1, centerY) != 1) { return 0; }
    if (getCell(grid, centerX, centerY) != 1) { return 0; }
    if (getCell(grid, centerX + 1, centerY) != 1) { return 0; }
    
    // Check surrounding cells are dead
    if (getCell(grid, centerX, centerY - 1) != 0) { return 0; }
    if (getCell(grid, centerX, centerY + 1) != 0) { return 0; }
    
    return 1;
}

function verifyThreeAlive(grid) {
    // Count how many cells are alive in the grid
    alive = 0;
    y = 0;
    while (y < grid.height) {
        x = 0;
        while (x < grid.width) {
            // getCell == 1 if alive and 0 if not
            alive = alive + getCell(grid, x, y);
            x = x + 1;
        }
        y = y + 1;
    }
    // Must be exactly 3
    if (alive == 3) { return 1; }
    return 0;
}

function benchmark(STEPS, GRID_SIZE) {
    grid = createGrid(GRID_SIZE, GRID_SIZE);
    
    // Setup blinker pattern
    setupVerticalBlinker(grid);
    
    // Run simulation for some number of steps (iterations)
    // Even numbers should return to original state
    step = STEPS * 2;
    i = 0;
    while (i < step) {
        grid = stepGrid(grid);
        // Check alternating pattern
        // This is an assertion checking correctness by verifying that exactly one 
        // of these 2 conditions should hold
        // We also check that there are always 3 cells in the grid
        if (((checkBlinkerHorizontal(grid) + checkBlinkerVertical(grid)) != 1) || (verifyThreeAlive(grid) != 1)) {
            println("Benchmark failed!");
            // We can return once a benchmark fails
            return;
        }
        i = i + 1;
    }
}

function main() {
    // Constants
    ITERATIONS = 500;
    // Warm up ends at 80% of total iterations
    WARMUP = 400;
    STEPS = 100;
    // GRID_SIZE >= 3 or else test won't properly work
    GRID_SIZE = 10;
    // Running time proportional to (ITERATIONS * STEPS * GRID_SIZE * GRID_SIZE)
    NAME = "ConwaysGameOfLife";

    time = 0;
    it = 0;

    while (it < ITERATIONS) {
        s = nanoTime();
        
        benchmark(STEPS, GRID_SIZE);
        e = nanoTime() - s;

        if (it >= WARMUP) {
            // Only measure after warming up
            time = time + e;
        }
        it = it + 1;
    }

    avg = time / (ITERATIONS - WARMUP);
    // Make sure you print the final result -- and no other things!
    println(NAME + ": " + avg);
}
