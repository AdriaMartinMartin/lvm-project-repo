/* Tests object creation and access
*
*/

function main() {
  obj = new();
  obj.a = 12;

  println(hasProperty(obj, a));

  obj["b"] = 23;
  println(hasProperty(obj, "b"));

  deleteProperty(obj, "b");
  println(hasProperty(obj, "b"));

  obj["c"] = null;

  println(hasProperty(obj, "c"));

  obj = null;

  println(hasProperty(obj, "x"));
  println(obj["b"]);
}
