// String test: Substring operations
function main() {
  // Test basic substring operations
  text = "Hello World";
  
  // Test subString from start
  sub1 = subString(text, 0, 5);
  println(sub1);
  
  // Test subString from middle
  sub2 = subString(text, 6, 11);
  println(sub2);
  
  // Test single character extraction
  char1 = subString(text, 0, 1);
  char2 = subString(text, 4, 5);
  char3 = subString(text, 10, 11);
  println(char1);
  println(char2);
  println(char3);
  
  // Test empty subString
  empty = subString(text, 5, 5);
  println(empty);
  println(typeOf(empty));
  
  // Test full string copy
  fullCopy = subString(text, 0, getSize(text));
  println(fullCopy);

  // Test subString with numbers converted to string
  number = 12345;
  numStr = "" + number;
  firstDigit = subString(numStr, 0, 1);
  lastDigit = subString(numStr, 4, 5);
  println(firstDigit);
  println(lastDigit);
  
  // Test subString operations on concatenated strings
  combined = "ABC" + "DEF";
  middle = subString(combined, 2, 4);
  println(middle);
  
  // Test string length after subString
  original = "Testing";
  part = subString(original, 0, 4);
  println(part);
  println(getSize(original));
  println(getSize(part));
  
  // Test stringSplit functionality
  sentence = "one two three";
  words = stringSplit(sentence);
  println(getSize(words));
  i = 0;
  while (i < getSize(words)) {
    println(words[i]);
    i = i + 1;
  }
  
  // Test string operations together
  sample = "Programming";
  prog = subString(sample, 0, 4);
  ming = subString(sample, 7, 11);
  combined = prog + ming;
  println(combined);
}
