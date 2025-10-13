function empty_string() {
  str = "";
  println(str + "(" + getSize(str) + "), hasSize: " + hasSize(str) + ", type: " + typeOf(str));
  
  str2 = str + str;
  println(str2 + "(" + getSize(str2) + "), hasSize: " + hasSize(str2) + ", type: " + typeOf(str2));

  str3 = "     ";
  println(str3 + "(" + getSize(str3) + "), hasSize: " + hasSize(str3) + ", type: " + typeOf(str3));
}

function main() {
  empty_string();
}