/*
 * STRING: Reverse iteration over tokens from stringSplit
 */

function main() {
    s = "Testing another string function right here innit";
    tokens = stringSplit(s);
    i = getSize(tokens);
    while (i > 0) {
        i = i - 1;
        println(tokens[i]);
    }
}
