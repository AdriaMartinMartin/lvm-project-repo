/*
 * Type of test: strings
 * Test very long strings by Ignacio Jimenez (i.j.jimenez.parapura@student.tue.nl)
 */

function main() {
    str1 = "this is a big string";

    i = 0;
    while (i < 10000) {
        str1 = str1 + " and even bigger";
        i = i + 1;
    }

    println(str1);
}