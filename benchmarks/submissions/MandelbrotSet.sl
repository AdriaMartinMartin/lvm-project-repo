// Mandelbrot set calculator
// "Simulates" drawing the iterations to the screen but actually just computes a value
// for the purpose of the benchmark

// Calculates "a % b".
function modulo(a, b) {
    div = a / b;
    return a - div * b;
}

function printlnAssert(s) {
    println("ASSERTION FAILED: " + s);
}

// Checks if a complex number is null and prints an assert statement if that's the case
function complexNumberNullCheck(c) {
    if (c == NULL) {
        printlnAssert("Complex number is NULL");
    }
}

// Constructor for a complex number object (takes a real and imaginary part)
function complexNum(real, imaginary) {
    if (real == NULL) {
        printlnAssert("Real part must be an integer when creating a complex number");
    }
    if (imaginary == NULL) {
        printlnAssert("Imaginary part must be an integer when creating a complex number");
    }

    complexNum = new();
    complexNum.r = real;
    complexNum.im = imaginary;
    return complexNum;
}

// Printing a complex number for debugging
function printComplexNum(c) {
    println("(" + c.r + " + " + "i)");
}

// Adds two complex numbers and returns a complex number
function addComplexNums(c1, c2) {
    complexNumberNullCheck(c1);
    complexNumberNullCheck(c2);

    return complexNum(c1.r + c2.r, c1.im + c2.im);
}

// Subtracts two complex numbers and returns a complex number
function subComplexNums(c1, c2) {
    complexNumberNullCheck(c1);
    complexNumberNullCheck(c2);

    c1Min = complexNum(0 - c1.r, 0 - c1.im);

    return addComplexNums(c1Min, c2);
}

// Squares two complex numbers and returns a complex number
function squareComplexNum(c) {
    complexNumberNullCheck(c);
    return complexNum(c.r * c.r - c.im * c.im, 2 * c.r * c.im);
}

// Calculates the distances (magnitude) of a complex number
function complexNumDist(c) {
    complexNumberNullCheck(c);
    return c.r * c.r + c.im * c.im;
}

// A given complex point "c" is part of the Mandelbrot set if the sequence
// does not escape past the radius of 2, even if the iterations are infinite.
// This function essentially calculates the escape rate.
function getMandelbrotIterations(max, c) {
    complexNumberNullCheck(c);

    if (max < 0) {
        printlnAssert("max cannot be negative");
    }

    Z = complexNum(0, 0);
    i = 0;

    while (i < max && complexNumDist(c) <= 4) {
        square = squareComplexNum(Z);
        Z = addComplexNums(square, c);

        if (Z == NULL) {
            printlnAssert("Z should not be NULL after adding the complex numbers");
        }

        i = i + 1;
    }

    return i;
}

// Convert a pixel's coordinates to complex plane
function cartesianSquareToComplex(x, y, w, h) {
    if (x < 0) {
        printlnAssert("x cannot be negative");
    }
    if (y < 0) {
        printlnAssert("x cannot be negative");
    }
    if (w < 0) {
        printlnAssert("width cannot be negative");
    }
    if (h < 0) {
        printlnAssert("height cannot be negative");
    }

    // Take into account the width and height of the canvas
    real = -2 + (3 * x) / w;
    imaginary = -1 + (2 * y) / h;
    return complexNum(real, imaginary);
}

// Basically create a checksum that allows us to combine all the Mandelbrot iterations
// and combine them into a single value.
function aggregateMandelbrot(iterations, accumulator) {
    if (iterations < 0) {
        printlnAssert("Iterations cannot be negative");
    }

    if (accumulator < 0) {
        printlnAssert("Accumulator cannot be negative");
    }

    // Prevent the aggregate from possibly becoming too large
    return modulo((iterations + accumulator), 1000000);
}

function computeMandelbrotIterationsForComplexNum(x, y, w, h, maxIterations) {
    c = cartesianSquareToComplex(x, y, w, h);
    iterations = getMandelbrotIterations(maxIterations, c);
    return iterations;
}

function computeMandelbrot(w, h, maxIterations) {
    result = 0;
    i = 0;
    j = 0;

    // Compute the mandelbrot set for every pixel
    // Normally you'd draw the results to some canvas
    // Since we can't do that here, we'll simulate that we're computing some sort of "result" value
    // by summing the amount of iterations and aggregating them.
    while (j < w) {
        while (i < h) {
            // Get a complex coordinate and calculate the number of mandelbrot iterations
            // For Mandelbrot, every pixel from the canvas needs to be converted to a complex number.
            iterations = computeMandelbrotIterationsForComplexNum(j, i, w, h, maxIterations);

            // Sum up the aggregated result
            result = result + aggregateMandelbrot(iterations, result);
            i = i + 1;
        }

        j = j + 1;
    }

    return result;
}

function benchmark() {
    mandelbrot =  computeMandelbrot(160, 90, 200);
    mandelbrot2 = computeMandelbrot(64, 32, 100);
    mandelbrot3 = computeMandelbrot(80, 45, 150);

    //
    // Test that the benchmark result is correct
    // Put some more for good measure
    //
    if (mandelbrot != 18766200 || mandelbrot2 != 2553500 || mandelbrot3 != 6145450) {
        println("Benchmark failed!");
    }
}

function main() {
    //
    // benchmark constants
    //
    ITERATIONS = 10000;
    MEASURE_FROM = 8000;
    NAME = "Mandelbrot_set";

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
