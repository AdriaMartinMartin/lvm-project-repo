// Category: strings

function main() {
  s = "a     b cd";
  tokens = stringSplit(s);

  i = getSize(tokens);
  while (i > 0) {
    i = i - 1;
    println(tokens[i]);
  }
}
