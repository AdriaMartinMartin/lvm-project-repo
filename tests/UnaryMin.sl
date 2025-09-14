function foo() {
  return 4;
}

function main() {  
  println(-1);       // -1
  println(- 1);

  println(+ 1);      // 1
  println(+1);

  println(1--2);     // = 1 + 2 = 3
  println(1 - -2);

  println(1+-2);     // = 1 + (-2) = -1
  println(1 + -2);

  println(-2-1);     // = -2 - 1 = -3
  println(-2 - 1);

  println(-2+1);     // = 1 - (+2) = -1
  println(-2 + 1);

  println(1---2);    // = 1 - (+2) = -1
  println(1 - --2);
  
  println(--2);      // Negation of negation -> 2
  println(---2);     // Negation of negation of negation -> -2

  println(3000000000000 + -4000000000000);

  println(-foo());
  println(1 - foo());

  println(1 - -foo());
}  
