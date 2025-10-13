//Other test
function main() {

    // short-circuit AND
    if (false && (1 / 0 > 0)) {
        println("should not print (AND)");
    }

    // short-circuit OR
    if (true || (1 / 0 > 0)) {
        println("short-circuit OR works");
    }
}
