function foo() {
  a = new();
  a.x = 1;
  a.y = 4;
  
  return a;
}

function main() {  
  a = new();
  s = "This is a test";

  println(hasSize(a));
  println(hasSize(s));
  println(hasSize(1));

  println(getSize(a));
  println(getSize(s));

  b = foo();
  println(hasSize(b));
  println(getSize(b));
}  
