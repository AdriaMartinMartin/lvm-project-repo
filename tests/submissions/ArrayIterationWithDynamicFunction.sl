// "objects/arrays"
function readAlphabet() {
 alphabet = new();
 alphabet[0] = "A";
 alphabet[1] = "B";
 alphabet[2] = "C";
 alphabet[3] = "D";
 alphabet[4] = "E";
 alphabet[5] = "F";
 alphabet[6] = "G";
 alphabet[7] = "H";
 alphabet[8] = "I";
 alphabet[9] = "J";
 alphabet[10] = "K";
 alphabet[11] = "L";
 alphabet[12] = "M";
 alphabet[13] = "N";
 alphabet[14] = "O";
 alphabet[15] = "P";
 alphabet[16] = "Q";
 alphabet[17] = "R";
 alphabet[18] = "S";
 alphabet[19] = "T";
 alphabet[20] = "U";
 alphabet[21] = "V";
 alphabet[22] = "W";
 alphabet[23] = "X";
 alphabet[24] = "Y";
 alphabet[25] = "Z";
 iterate(alphabet);
}


function main() {  
  defineFunction("function iterate(array) { i = 0; while (i < getSize(array)){println(array[i]); i = i + 1;}}");
  readAlphabet();
}
