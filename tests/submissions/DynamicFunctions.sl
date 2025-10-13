
// Other tests

function null(){

}

// Calculate with 10 using a dynamically defined calculator function
function calculateWith10(number){
   return calculator(number, 10);
}


// Calculate salary based on employee type (determined by dynamically defined function)
function calculateSalary(employeeName){
    isManager = getTypeByName(employeeName);

    if(isManager){
       return 2000;
    }
    else
    {
       return 1500;
    }
}

// Simulate finding a name from database using a dynamically defined db function
function findNameFromDatabase(name){

    index = -1;

    //find index from name
    if (name == "surname")
    {
       index = 0;
    }

    if (name == "first name")
    {
       index = 1;
    }

    if (name == "random name")
    {
       index = 2;
    }

    if (name == "random name 2")
    {
       index = 3;
    }

    return db(index);
}


// Get name by index from static array
function getNameByIndex(index) {

    // index not found!
    if(index == -1){
      return null();
    }


    arr = new();
    arr[0] = "surname";
    arr[1] = "first name";
    arr[2] = "random name";
    arr[3] = "random name 2";
    return arr[index];
}

function isCEO(name) {
    if (name == "CEO")
    {
        return true;
    }else
    {
        return false;
    }
}

function main() {

    // Test 1: Dynamic Calculator Function

    // Define calculator as addition
    defineFunction("function calculator(a, b) { return a + b; }");
    result1 = calculateWith10(20);
    println(result1); // should return 30

    // Redefine calculator as subtraction
    defineFunction("function calculator(a, b) { return a - b; }");
    result2 = calculateWith10(20);
    println(result2); // should return 10

    // Redefine as multiplication
    defineFunction("function calculator(a, b) { return a * b; }");
    result3 = calculateWith10(20);
    println(result3); // should return 200

    // Redefine as division (integer)
    defineFunction("function calculator(a, b) { return a / b; }");
    result4 = calculateWith10(20);
    println(result4); // should return 2


    // Test 2: Dynamic Employee Type Function

    // Define getTypeByName to always return true (manager)
    defineFunction("function getTypeByName(name) { return true; }");
    result5 = calculateSalary("surname");
    println(result5); // should return 2000

    // Redefine to return false (non-manager)
    defineFunction("function getTypeByName(name) { return false; }");
    result6 = calculateSalary("first name");
    println(result6); // should return 1500

    // Redefine to check specific names
    defineFunction("function getTypeByName(name) { return isCEO(name); }");
    result7 = calculateSalary("CEO");
    println(result7); // should return 2000


    defineFunction("function getTypeByName(name) { return isCEO(name); }");
    result8 = calculateSalary("Intern");
    println(result8); // should return 1500


    // Test 3: Dynamic Database Function

    // Define db to use getNameByIndex
    defineFunction("function db(index) { return getNameByIndex(index); }");
    result9 = findNameFromDatabase("first name");
    println(result9); // should return first name

    result10 = findNameFromDatabase("surname");
    println(result10); // should return surname

    result11 = findNameFromDatabase("random name 2");
    println(result11); // should return random name 2

    // Test invalid name
    result12 = findNameFromDatabase("Unknown");
    println(result12); // should return NULL

    // Test 4: Edge Cases and Stress Tests

    // Test with large numbers in calculator
    defineFunction("function calculator(a, b) { return a + b; }");
    big = 9000000000000000000;
    result13 = calculateWith10(big);
    println(result13); // should return 9000000000000000010

    // Test null input
    defineFunction("function getTypeByName(name) { return name != null(); }");
    result14 = calculateSalary(null());
    println(result14); // should return 1500 (since null != null() is false)

    // Test redefinition in loop
    i = 0;
    while (i < 3) {
        defineFunction("function calculator(a, b) { return a + b + " + i + "; }");
        temp = calculateWith10(5);
        println(temp); // should return 15, 16, 17
        i = i + 1;
    }
}