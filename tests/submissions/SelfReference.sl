/*
 * ARRAY/OBJECT: Testing self reference loops with objects
 */

function main() {
  obj = new();
  obj.self = obj;
  obj.value = 73;
  current = obj;
  i = 0;
  while(i < 10000) {
    current = current.self;
    i = i + 1;
  }
  println(current.value);
}
