// benchmark test
// Producing all permutations is O(n!). This is large enough for a benchmark.

function backtracking(result, str, originStr, used) {
  if (getSize(str) == getSize(originStr)) {
    result[getSize(result)] = str;
    return result;
  }

  i = 0;
  while (i < getSize(originStr)) {
    if (used[i]) {
      i = i + 1;
      continue;
    }

    used[i] = true;
    subStr = subString(originStr, i, i + 1);
    backtracking(result, str + subStr, originStr, used);
    used[i] = false;
    i = i + 1;
  }
  
  return result;
}

function permutation(str) {
  used = new();
  i = 0;
  while (i < getSize(str)) {
    used[i] = false;
    i = i + 1;
  }

  result = backtracking(new(), "", str, used);

  return result;
}

function expectedPermutation() {
  result = new();
  
  result[0] = "ABCDE";
  result[1] = "ABCED";
  result[2] = "ABDCE";
  result[3] = "ABDEC";
  result[4] = "ABECD";
  result[5] = "ABEDC";
  result[6] = "ACBDE";
  result[7] = "ACBED";
  result[8] = "ACDBE";
  result[9] = "ACDEB";
  result[10] = "ACEBD";
  result[11] = "ACEDB";
  result[12] = "ADBCE";
  result[13] = "ADBEC";
  result[14] = "ADCBE";
  result[15] = "ADCEB";
  result[16] = "ADEBC";
  result[17] = "ADECB";
  result[18] = "AEBCD";
  result[19] = "AEBDC";
  result[20] = "AECBD";
  result[21] = "AECDB";
  result[22] = "AEDBC";
  result[23] = "AEDCB";
  result[24] = "BACDE";
  result[25] = "BACED";
  result[26] = "BADCE";
  result[27] = "BADEC";
  result[28] = "BAECD";
  result[29] = "BAEDC";
  result[30] = "BCADE";
  result[31] = "BCAED";
  result[32] = "BCDAE";
  result[33] = "BCDEA";
  result[34] = "BCEAD";
  result[35] = "BCEDA";
  result[36] = "BDACE";
  result[37] = "BDAEC";
  result[38] = "BDCAE";
  result[39] = "BDCEA";
  result[40] = "BDEAC";
  result[41] = "BDECA";
  result[42] = "BEACD";
  result[43] = "BEADC";
  result[44] = "BECAD";
  result[45] = "BECDA";
  result[46] = "BEDAC";
  result[47] = "BEDCA";
  result[48] = "CABDE";
  result[49] = "CABED";
  result[50] = "CADBE";
  result[51] = "CADEB";
  result[52] = "CAEBD";
  result[53] = "CAEDB";
  result[54] = "CBADE";
  result[55] = "CBAED";
  result[56] = "CBDAE";
  result[57] = "CBDEA";
  result[58] = "CBEAD";
  result[59] = "CBEDA";
  result[60] = "CDABE";
  result[61] = "CDAEB";
  result[62] = "CDBAE";
  result[63] = "CDBEA";
  result[64] = "CDEAB";
  result[65] = "CDEBA";
  result[66] = "CEABD";
  result[67] = "CEADB";
  result[68] = "CEBAD";
  result[69] = "CEBDA";
  result[70] = "CEDAB";
  result[71] = "CEDBA";
  result[72] = "DABCE";
  result[73] = "DABEC";
  result[74] = "DACBE";
  result[75] = "DACEB";
  result[76] = "DAEBC";
  result[77] = "DAECB";
  result[78] = "DBACE";
  result[79] = "DBAEC";
  result[80] = "DBCAE";
  result[81] = "DBCEA";
  result[82] = "DBEAC";
  result[83] = "DBECA";
  result[84] = "DCABE";
  result[85] = "DCAEB";
  result[86] = "DCBAE";
  result[87] = "DCBEA";
  result[88] = "DCEAB";
  result[89] = "DCEBA";
  result[90] = "DEABC";
  result[91] = "DEACB";
  result[92] = "DEBAC";
  result[93] = "DEBCA";
  result[94] = "DECAB";
  result[95] = "DECBA";
  result[96] = "EABCD";
  result[97] = "EABDC";
  result[98] = "EACBD";
  result[99] = "EACDB";
  result[100] = "EADBC";
  result[101] = "EADCB";
  result[102] = "EBACD";
  result[103] = "EBADC";
  result[104] = "EBCAD";
  result[105] = "EBCDA";
  result[106] = "EBDAC";
  result[107] = "EBDCA";
  result[108] = "ECABD";
  result[109] = "ECADB";
  result[110] = "ECBAD";
  result[111] = "ECBDA";
  result[112] = "ECDAB";
  result[113] = "ECDBA";
  result[114] = "EDABC";
  result[115] = "EDACB";
  result[116] = "EDBAC";
  result[117] = "EDBCA";
  result[118] = "EDCAB";
  result[119] = "EDCBA";

  return result;
}

function benchmark() {
  str = "ABCDE";
  result = permutation(str);
  i = 0;
  while (i < getSize(result)) {
    i = i + 1;
  }
  
  //
  // Test that the benchmark result is correct
  //
  expectedResult = expectedPermutation();
  if (getSize(result) != getSize(expectedResult)) {
    println("Benchmark failed!");
  }

  j = 0;
  while (j < getSize(expectedResult)) {
    if (result[j] != expectedResult[j]) {
      println("Benchmark failed!");
      break;
    }
    j = j + 1;
  }
}

function main() {
  ITERATIONS = 10000;
  MEASURE_FROM = 8000;
  NAME = "Permutation";

  time = 0;
  it = 0;

  while (it < ITERATIONS) {
    s = nanoTime();
    benchmark();
    e = nanoTime() - s;
    if (it >= MEASURE_FROM) {
      time = time + e;
    }
    it = it + 1;
  }

  avg = time / (ITERATIONS - MEASURE_FROM);
  println(NAME + ": " + avg);
}
