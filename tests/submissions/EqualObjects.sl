/*
 *  Test 4 objects/arrays 
 */

function main() {
    obj1 = new();
    obj1.x = 3;

    obj2 = new();
    obj2.x = 3;

    println(obj1 == obj2); // expected output: false

    obj3 = new();
    obj3.x = 3;
    
    obj4 = obj3;

    println(obj3 == obj4); // expected output: true
}