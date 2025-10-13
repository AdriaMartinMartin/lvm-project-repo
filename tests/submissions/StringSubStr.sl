function substr() {
        // Create various substrings out of normal strings and strings with too many spaces
        str = "Hello, Good Morning!";
        words = stringSplit(str);
        println(getSize(words) + ", " + typeOf(words));

        index = 0;
        while (index < getSize(words)) {
                println(words[index] + " at index " + index + " (" + typeOf(words[index]) + ")");
                index = index + 1;
        }

        str_space = " spaces ";
        elements = stringSplit(str_space);
        println(getSize(elements) + ", " + typeOf(elements));
        index = 0;
        while (index < getSize(elements)) {
                println(elements[index] + " at index " + index + " (" + typeOf(elements[index]) + ")");
                index = index + 1;
        }

        str_empty = "";
        empty_words = stringSplit(str_empty);
        index = 0;
        while (index < getSize(empty_words)) {
                println(empty_words[index] + " at index " + index + " (" + typeOf(empty_words[index]) + ")");
                index = index + 1;
        }
}

function main() {
        substr();
}