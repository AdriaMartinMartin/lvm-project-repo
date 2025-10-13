// "strings" test

function main() {
    string1 = "A string without duplicated word";
    string2 = "A string with duplicated word: word word word";
    string3 = "foobark foo bar bark bank fool";

    println(checkDuplicatedWord(string1));
    println(checkDuplicatedWord(string2));
    println(checkDuplicatedWord(string3));
}

function checkDuplicatedWord(inputString) {
    tokens = stringSplit(inputString);

    len = getSize(tokens);

    i = 0;
    while (i < len) {
      j = i + 1;
      while (j < len) {
        if (tokens[i] == tokens[j]) {
          return true;
        }
        j = j + 1;
      }
      i = i + 1;
    }

    return false;
}