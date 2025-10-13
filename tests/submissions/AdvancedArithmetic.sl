/*
 * Computations: Advanced arithmetic with large numbers, and function such as power() and factorial()
 */

function power(base, exp) {
    result = 1;
    i = 0;
    while (i < exp) {
        result = result * base;
        i = i + 1;
    }
  
    return result;
}

function factorial(n) {
    fact = 1;
    i = 1;
    while (i <= n) {
        fact = fact * i;
        i = i + 1;
    }
    
    return fact;
}

function main() {
    big1 = 123456789012345;
    big2 = 987654321098765;

    sum = big1 + big2;
    if (sum == 1111111110111110) {
        println(sum);
    } else {
        println("ERROR: big1 + big2 should be 1111111110111110, got " + sum);
    }

    diff = big2 - big1;
    if (diff == 864197532086420) {
        println(diff);
    } else {
        println("ERROR: big2 - big1 should be 864197532086420, got " + diff);
    }

    prod = big1 * 99;
    if (prod == 12222222112222155) {
        println(prod);
    } else {
        println("ERROR: big1 * 99 should be 12222222112222155, got " + prod);
    }

    div = big2 / 12345;
    if (div == 80004400251) { 
        println(div);
    } else {
        println("ERROR: big2 / 12345 should be 80004400251, got " + div);
    }

    expr = (big1 * 2 + big2 / 3 - (big1 / 97)) * (7 - 3);
    expectedExpr = ((big1 * 2) + (big2 / 3) - (big1 / 97)) * 4; 
    if (expr == expectedExpr) {
        println(expr);
    } else {
        println("ERROR: expr should be " + expectedExpr + ", got " + expr);
    }

    powResult = power(12, 8);
    if (powResult == 429981696) {
        println(powResult);
    } else {
        println("ERROR: power(12, 8) should be 429981696, got " + powResult);
    }

    factResult = factorial(13);
    if (factResult == 6227020800) {
        println(factResult);
    } else {
        println("ERROR: factorial(13) should be 6227020800, got " + factResult);
    }
}