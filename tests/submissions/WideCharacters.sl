// "strings" test.

// Test the presence of wide characters in strings.

function main() {
    // Only wide characters.
    println("你好世界");
    println("こにちはせかい");
    println("Приветмир");

    // Mix of small- and wide characters.
    println("1你好a世界!");
    println("1こにちはaせかい!");
    println("1Приветa мир!");

    // String concatenation between small- and wide characters.
    println("你好" + "world");
    println("你好" + "世界");
    println("こにちは" + "world");
    println("こにちは" + "世界");
    println("Привет" + "world");
    println("Привет" + "мир");
}
