// [objects/arrays] sparse array test

function main() {
    a = new();
    a[0] = "zero";
    a[2] = "two";
    a[500] = "five hundred";
    a[1000] = "thousand";

    println(getSize(a));  // 4
    println(a[0]);
    println(a[2]);
    println(a[500]);
    println(a[1000]);
}