// string test

function main() {
  s1 = "";
  println(hasSize(s1));
  println(getSize(s1));

  s2 = "    ";
  println(hasSize(s2));
  println(getSize(s2));

  splittedS2 = stringSplit(s2);
  println(hasSize(splittedS2));
  println(getSize(splittedS2));
}
