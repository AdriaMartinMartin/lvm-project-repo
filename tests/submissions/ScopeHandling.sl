// Other test: Scope and variable handling

function calculate(num) {
    temp = num * 3;
    return temp + 5;
}

function processNumbers(a, b) {
    sum = a + b;
    if (sum > 10) {
        bonus = 100;
        sum = sum + bonus;
    }
    return sum;
}

function changeValue(x) {
    x = x * 2;
    return x;
}

function main() {
    counter = 0;
    println(counter);
    
    result = calculate(7);
    println(result);
    counter = counter + result;
    println(counter);
    
    value1 = processNumbers(3, 4);
    println(value1);
    
    value2 = processNumbers(6, 8);
    println(value2);
    
    original = 15;
    println(original);
    
    modified = changeValue(original);
    println(modified);
    println(original);
    
    data = 50;
    println(data);
    data = "hello";
    println(data);
    data = true;
    println(data);
}
