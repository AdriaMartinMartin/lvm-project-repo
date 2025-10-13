/*
 * String: Testing longer strings, and the subString(), getSize(), hasSize(), and typeOf()
 */

function main() {
    s = "This is a very important, and long message, that needs to be considered in the most important code ever. To test the most important function ever.";

    s2 = subString(s, 0, 6);
    if (s2 == "This i") {
        println(s2);
    } else {
        println("ERROR: s2 should be 'This i', got '" + s2 + "'");
    }

    s3 = subString(s, 20, 55);
    if (s3 == "tant, and long message, that needs ") {
        println(s3);
    } else {
        println("ERROR: s3 should be 'tant, and long message, that needs ', got '" + s3 + "'");
    }

    s4 = subString(s, 57, 90);
    if (s4 == " be considered in the most import") {
        println(s4);
    } else {
        println("ERROR: s4 should be ' be considered in the most import', got '" + s4 + "'");
    }

    size = getSize(s);
    if (size == 146) {
        println(size);
    } else {
        println("ERROR: size should be 146, got " + size);
    }

    has = hasSize(s);
    if (has == true) {
        println(has);
    } else {
        println("ERROR: hasSize should be true, got " + has);
    }

    println(typeOf(s));
}