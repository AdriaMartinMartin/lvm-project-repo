// Benchmark using NPrimesSum
// Code has some ineficiencies intentionally to make it a better benchmark
// Subtract divisor until remainder is less than the divisor
function subtractUntilLess(value, divisor) 
{
    // copy original value
    remainder = value;

    // keep subtracting divisor
    while (remainder >= divisor) 
    {
        remainder = remainder - divisor;
    }

    // return the final remainder
    return remainder;
}

// Check if a number is divisible by divisor
function isDivisible(value, divisor) 
{
    remainder = subtractUntilLess(value, divisor);

    if (remainder == 0) 
    {
        return 1;
    }
    else 
    {
        return 0;
    }
}

// Check if a number is prime
function isPrime(num) 
{
    // Numbers less than 2 are not prime
    if (num < 2) 
    { 
        return 0; 
    }

    // 2 is prime
    if (num == 2) 
    { 
        return 1; 
    }

    // divisor starts at 2
    i = 2;

    // compute condition separately
    condition = i * i <= num;

    while (condition) 
    {
        // check divisibility
        divisible = isDivisible(num, i);

        if (divisible == 1) 
        { 
            return 0; 
        }

        // increment divisor
        i = i + 1;

        // update condition
        condition = i * i <= num;
    }

    // If no divisors found, num is prime
    return 1;
}

// Helper to update the running sum
function updateSum(sum, value) 
{
    tempSum = sum + value;
    return tempSum;
}

// Helper to increment a counter
function incrementCounter(counter) 
{
    tempCounter = counter + 1;
    return tempCounter;
}

// Function to compute the sum of the first N prime numbers
function NPrimeSum(N) 
{
    // Accumulator for the sum of primes 
    sum = 0;    

    // primes counted   
    count = 0;  

    // current number to test    
    current = 2;   

    // temporary flag 
    flag = 0;    

    // store loop condition separately
    condition = count < N;

    // Keep going until we’ve found N primes
    while (condition) 
    {
        flag = isPrime(current);

        if (flag == 1) 
        {
            // If prime, add to sum
            sum = updateSum(sum, current);

            // increment prime count
            count = incrementCounter(count);
        }

        // Move on to the next number
        current = current + 1;

        // update condition
        condition = count < N;
    }

    return sum;
}

// Benchmark function summing first N primes
function benchmark() 
{
    // number of primes to sum
    N = 500;      

    // calculate the sum
    sum = NPrimeSum(N);

    // known expected result for first 500 primes
    expected = 824693; 

    // check correctness
    if (sum != expected) 
    {
        println("Benchmark failed!");
    }
}

// Benchmark harness
function main() 
{
    //
    // benchmark constants
    //
    ITERATIONS = 2000;
    MEASURE_FROM = 1600;
    NAME = "NPrimeSum";

    //
    // harness
    //
    time = 0;
    it = 0;

    // explicit loop condition variable
    loopCondition = it < ITERATIONS;

    while (loopCondition) 
    {
        s = nanoTime();

        benchmark();

        e = nanoTime() - s;

        if (it >= MEASURE_FROM) 
        {
            time = time + e;
        }

        it = it + 1;

        loopCondition = it < ITERATIONS;
    }

    avg = time / (ITERATIONS - MEASURE_FROM);

    // Make sure you print the final result -- and no other things!
    println(NAME + ": " + avg);
}
