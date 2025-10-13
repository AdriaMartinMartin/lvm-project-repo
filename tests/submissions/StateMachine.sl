// "array/object" test.

// Test for an object showing different behaviour using a state design pattern.
// This shows the following functionality:
//   - Dynamic functions via 'defineFunction'.
//   - Returning dynamic objects holding functions.
//   - Calling functions with the same name, but different functionality.
//   - Overwriting a function defined by defineFunction, but outside the scope where it is defined.

// Workaround because we cannot print strings in 'defineFunction' because both are defined using '"'.
function driving() { println("driving"); }
function sailing() { println("sailing"); }
function flying() { println("flying"); }
function crashing() { println("crashing the vehicle"); }

function getObject(terrain) {
    obj = new();

    if (terrain == "land") {
        action = "driving";
        defineFunction("function transport() { driving(); }");
        obj.drive = transport;
    } 
    if (terrain == "sea") {
        action = "sailing";
        defineFunction("function transport() { sailing(); }");
        obj.drive = transport;
    }
    if (terrain == "air") {
        action = "flying";
        defineFunction("function transport() { flying(); }");
        obj.drive = transport;
    }

    return obj;
}

function main() {
    // Test if the object/function is overwritten correctly.
    vehicle = getObject("land");
    vehicle.drive();
    vehicle = getObject("sea");
    vehicle.drive();
    vehicle = getObject("air");
    vehicle.drive();

    // Test if a call to defineFunction overwrites the drive function.
    println("");
    vehicle = getObject("land");
    vehicle.drive();
    defineFunction("function transport() { crashing(); }");
    vehicle.drive();
}
