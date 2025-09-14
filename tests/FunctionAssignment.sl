
function foo() {
  return "This is foo";
}

function main () {
  bar = foo;
  println(typeOf(foo));
  println(typeOf(bar));
  println(foo()); 
  println(bar()); 
}
