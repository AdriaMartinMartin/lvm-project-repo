// "string"
function main() {  
  array = new();
  
  array[0] = "A";
  array[1] = "B";
  array[2] = "C";
  array[3] = "D";
  array[4] = "E";
  array[5] = "F";
  array[6] = "G";
  array[7] = "H";
  array[8] = "I";
  array[9] = "J";
  array[10] = "K";
  
  result = "";
  i = 0;
  while (i < getSize(array)) {
      result = result + array[i];
      i = i + 1;
  } 
  println(result);
}