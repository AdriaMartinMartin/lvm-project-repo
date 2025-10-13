/*
 * Tests other features (argument passing)
 */

function increment(a) {
  a = a + 1;
}

function incrementAttribute(a) {
  a.value = a.value + 1;
}

function main(){
  a = 5;
  increment(a);
  println(a);

  b = new();
  b.value = 5;
  incrementAttribute(b);
  println(b.value);
}

