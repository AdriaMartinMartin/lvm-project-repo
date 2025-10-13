// "objects/arrays" tests

function main() {
    array = new();

    array[0] = 0;
    println(array[0]);
    println("getSize(array): " + getSize(array));

    array[0] = 42;
    println(array[0]);
    println("getSize(array): " + getSize(array));

    array[0] = true;
    println(array[0]);
    println("getSize(array): " + getSize(array));

    array[0] = "string";
    println(array[0]);
    println("getSize(array): " + getSize(array));
}