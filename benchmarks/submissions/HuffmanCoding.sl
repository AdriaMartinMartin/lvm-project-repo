// Note: This implementation requires that there are at least two unique characters in the raw string.

// Note: Not every Huffman coding implementation is the same so the exact bitstring result might differ from online
// versions. However, the output length should be the same. This is because there is no fixed way to merge nodes
// with equal subtree sizes.

// Helpers

function getNull() {
}

/* Do not use this, it does not work, :/
function swap(a, b) {
  temp = b;
  b = a;
  a = temp;
} */


// Heap operations

function insertHeap(heap, node) {
  index = getSize(heap) + 1;
  heap[index] = node;
  siftUp(heap, index);
}

function extractTopHeap(heap) {
  size = getSize(heap);
  if (size == 1) {
    result = heap[1];
    deleteProperty(heap, "1");
    return result;
  }
  temp = heap[size];
  heap[size] = heap[1];
  heap[1] = temp;
  result = heap[size];
  deleteProperty(heap, "" + size);
  siftDown(heap, 1);
  return result;
}

function lessThanNode(node1, node2) {
  return node1.occurrence < node2.occurrence;
}

function siftDown(heap, index) {
  size = getSize(heap);
  leftChildIndex = index * 2;
  if (leftChildIndex > size) {
    return;
  }

  lowestChildIndex = leftChildIndex;
  rightChildIndex = leftChildIndex + 1;
  if (rightChildIndex <= size) {
    if (lessThanNode(heap[rightChildIndex], heap[leftChildIndex])) {
      lowestChildIndex = rightChildIndex;
    }
  }

  if (lessThanNode(heap[lowestChildIndex], heap[index])) {
    temp = heap[index];
    heap[index] = heap[lowestChildIndex];
    heap[lowestChildIndex] = temp;
    siftDown(heap, lowestChildIndex);
  }
}

function siftUp(heap, index) {
  if (index == 1) {
    return;
  }
  parentIndex = index / 2;
  if (lessThanNode(heap[index], heap[parentIndex])) {
    temp = heap[index];
    heap[index] = heap[parentIndex];
    heap[parentIndex] = temp;
    siftUp(heap, parentIndex);
  }
}

/*
 * The heap is a min-heap that contains Node objects. This min-heap is used to build the Huffman tree
 * Node properties:
 * left, right: Contains references to left and right children
 * occurrence: Contains occurrence count of all characters in subtree
 * char: If node is a leaf node this property exists and contains the char
 */
function createHeap(huffmanEncoding, rawString) {
  huffmanEncoding.heap = new();
  i = 0;
  uniqueChars = getSize(huffmanEncoding.occurrenceCount);
  while (i < uniqueChars) {
    node = new();
    node.left = getNull();
    node.right = getNull();
    node.char = huffmanEncoding.IDToChar[i];
    node.occurrence = huffmanEncoding.occurrenceCount[i];
    insertHeap(huffmanEncoding.heap, node);
    i = i + 1;
  }
}

function constructHuffmanTree(heap) {
  while (getSize(heap) > 1) {
    l = extractTopHeap(heap);
    r = extractTopHeap(heap);
    // println("EXTRACT FROM HEAP: " + l.occurrence + " " + r.occurrence);
    node = new();
    node.left = l;
    node.right = r;
    node.occurrence = l.occurrence + r.occurrence;
    insertHeap(heap, node);
  }
}


// Encode Huffman

function mapCharactersToBitString(node, curString, map, revMap) {
  if (hasProperty(node, "char")) {
    // println(node.char + ": " + curString);
    map[node.char] = curString;
    revMap[curString] = node.char;
    return;
  }
  mapCharactersToBitString(node.left, curString + "0", map, revMap);
  mapCharactersToBitString(node.right, curString + "1", map, revMap);
}

function countCharacterOccurrence(huffmanEncoding, rawString) {
  huffmanEncoding.occurrenceCount = new();
  rawStringLength = getSize(rawString);
  i = 0;
  while (i < rawStringLength) {
    char = subString(rawString, i, i + 1);
    ID = huffmanEncoding.charToID[char];
    if (ID < getSize(huffmanEncoding.occurrenceCount)) {
      huffmanEncoding.occurrenceCount[ID] = huffmanEncoding.occurrenceCount[ID] + 1;
    }
    if (ID >= getSize(huffmanEncoding.occurrenceCount)) {
      huffmanEncoding.occurrenceCount[ID] = 1;
    }
    i = i + 1;
  }
}

function assignIDs(huffmanEncoding, rawString) {
  huffmanEncoding.charToID = new();
  huffmanEncoding.IDToChar = new();
  rawStringLength = getSize(rawString);
  i = 0;
  while (i < rawStringLength) {
    char = subString(rawString, i, i + 1);
    if (hasProperty(huffmanEncoding.charToID, char) == false) { // I can't get the ! operator to work?
      ID = getSize(huffmanEncoding.charToID);
      huffmanEncoding.charToID[char] = ID;
      huffmanEncoding.IDToChar[ID] = char;
    }
    i = i + 1;
  }
}

function encodeHuffman(rawString) {
  huffmanEncoding = new();
  assignIDs(huffmanEncoding, rawString);
  countCharacterOccurrence(huffmanEncoding, rawString);
  createHeap(huffmanEncoding, rawString);
  constructHuffmanTree(huffmanEncoding.heap);
  huffmanEncoding.charToBitString = new();
  huffmanEncoding.bitStringToChar = new();
  mapCharactersToBitString(huffmanEncoding.heap[1], "", huffmanEncoding.charToBitString, huffmanEncoding.bitStringToChar);

  result = "";
  i = 0;
  size = getSize(rawString);
  while (i < size) {
    char = subString(rawString, i, i + 1);
    result = result + huffmanEncoding.charToBitString[char];
    i = i + 1;
  }
  huffmanEncoding.encodedString = result;
  return huffmanEncoding;
}


// Decode Huffman

function decodeHuffman(encodedString, bitStringToChar) {
  decodedString = "";
  i = 0;
  size = getSize(encodedString);
  while (i < size) {
    j = i + 1;
    while (hasProperty(bitStringToChar, subString(encodedString, i, j)) == false) {
      j = j + 1;
    }
    decodedString = decodedString + bitStringToChar[subString(encodedString, i, j)];
    i = j;
  }
  return decodedString;
}


// Benchmark

function benchmark() {
  // "abf bbcafaacccfcfff" -> "000111101001101110001100001010101110111111"

  rawString = "Lorem ipsum dolor sit amet consectetur adipiscing elit. Pretium tellus duis convallis tempus leo eu aenean. Iaculis massa nisl malesuada lacinia integer nunc posuere. Conubia nostra inceptos himenaeos orci varius natoque penatibus. Nulla molestie mattis scelerisque maximus eget fermentum odio. Blandit quis suspendisse aliquet nisi sodales consequat magna. Ligula congue sollicitudin erat viverra ac tincidunt nam. Velit aliquam imperdiet mollis nullam volutpat porttitor ullamcorper. Dui felis venenatis ultrices proin libero feugiat tristique. Cubilia curae hac habitasse platea dictumst lorem ipsum. Sem placerat in id cursus mi pretium tellus. Fringilla lacus nec metus bibendum egestas iaculis massa. Taciti sociosqu ad litora torquent per conubia nostra. Ridiculus mus donec rhoncus eros lobortis nulla molestie. Mauris pharetra vestibulum fusce dictum risus blandit quis. Finibus facilisis dapibus etiam interdum tortor ligula congue. Justo lectus commodo augue arcu dignissim velit aliquam. Primis vulputate ornare sagittis vehicula praesent dui felis. Senectus netus suscipit auctor curabitur facilisi cubilia curae. Quisque faucibus ex sapien vitae pellentesque sem placerat.";
  huffmanEncoding = encodeHuffman(rawString);
  decodedString = decodeHuffman(huffmanEncoding.encodedString, huffmanEncoding.bitStringToChar);
  //
  // Test that the benchmark result is correct
  //

  answerEncodedString = "000000110111010100111110100100001000011101110010100100101011111010110111010100100110100101111001011101001111011110011100111010001110111111110001111111011111000100100101110101100100001001110111100001000101010010011110110001011110101010001011011101001111011100111001010010001111111011001101100110110010101111000011101100111001110100010101111101101100110001110110001111111101000000111001101100011011111110110011111100100101111110001111110110001101010100010111011010111110011000110001110110010100101111011101101110000010011101011010010100101101101111110111001011101011101110001101011111000010001001101110000100010111111101010011110100100000111000001111001000000111101110111001111010011111010101000101110001110100011100010101001101110000011110111010111010010111000010001111001111000010111111011101100000000000110100111100011011111111101110110011101010011100001100010111110110100001110011011000001101101111110100000111001111100000011111000110110111001010101110011011010101000101110010110001100110101110010100111010110111111010111001111110010100101101110111001110110011011110011110110111101000011101000001110011111001010010110000001000110100110011011001111010100111101111000101100111101001010011110001011111001010010011101101011001111011010101000101110011011010110001101011001011110000000111000011101100110111001101000011111000110101100111011101111110010110110001000001110011110111100000100111010011001101111011010111011011011111101100111001110100011101111100000111001011011110010100101101010000011011101010100000000110001010100110001101011100111001110100010101001100111110011011110101100110001111000010111110010101100100011001111010010110111100010111100101011111111010001001011100101111100100011100100011110000110101111000001011110000011011101001010101000101110100111101100010111100101101100010000011100101110100100001101000000111110100101011001111101111001010011101011001100011101100000111000110011010111010010001011111110101101100011100001101101111000000111101010001110111001011111101010010011000110011010111010011100111010100000011111010010101010001011101011100001100010110011110110001110110001011111111000111110001101101110011101100110001100111010000111100111111011000000101001110100100011000110001010101111101001110110001011001111110001010000110110111100011101000011101011100100000111001111101010100010111000110001010100101100011011100111001100010010111111100000000010111110010000000001011010101001011110111101110111111000000101101011011111111011100101011001111000111110010100110101111000110111010100111110100100001000011101110010100101010100000000111111110100100000010110101111100111101001011011110000100011000011010111001110011000100110111001101100101000011000000101001111011100111001010010001111111011001101100110110101010001011010001000010001010100001011001101011100011010111110011001101100000111111110010010100111101111100110110001010100101010111110001101011110010100100111101010011111101011110111101100001101111100110001100011101100101001011110111011011101010100010111011110111110000101110011001101111011110000111101110100000111001001011101011100011000101111110101001011100011111101010000000111001111000101111000000111110100100111001110100011100010101001101110000011110111010111010010111010101000101101100001101011001111001100011011001101100101001100110110010101111101000111111110010001000000000111010001111001100110110011110100111011101100011011101010101111010100011100111011000001110001100110101110010100111010110111111010111001111110101010001011011011011110001000011101100000010000000101101001111011101001011100010111111111101011100101010111000110110010100100010110011001101111001111100101011001111000111110010100100010000111011100110110001010101101011000110101100101111000000011100001110110101010001011010000100010010101011100110110001011001011111000010110001110100111011001010111011000010010101011100110110011110111001101110100100001000101111111010010101111001010010001111110101000111111010100100011000101010011000110101110011100111010001010100110011111010101000101101010110011010111111011000110111111100011111001101100111001110110100101001110110101111101100101111000101001100111110010110100111001100100101011001010100000100111011101001101001000101111111101100010111100101101100010000011100101110100101010100010110111010000110100001110110001011111100011000001110001111011011111111001110101000001101101001111100110110110101000010111011100111011000101111111100000000011110011000110101110000001010010111111110111110001011110010101111000011000101100111101100011101101010100000000111111100011111111000111110011011000001111101111100110110011011100110111100001000010010111100101111001110001111110101001001110011000100101101010100101111100010010001011001011111000010110001110100110011100110001010100101100011011100111001100010010111111101010100010110101111000011101000001110011111000101100101111001110000101010111001101100111100000010100110110110000100111110001100010111100101111011111110000001111101100110111100010111111111010000011100111110011011111101001000000101101011111001111010010110111101010";
  if ((answerEncodedString != huffmanEncoding.encodedString) || (rawString != decodedString)) {
    println("Benchmark failed!");
  }
  //println(huffmanEncoding.encodedString);
  //println(decodedString);
}


// Main


function main() {
  //
  // benchmark constants
  //
  ITERATIONS = 5000;
  MEASURE_FROM = 4000;
  NAME = "HuffmanCoding";

  //
  // harness
  //
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
  // Make sure you print the final result -- and no other things!
  println(NAME + ": " + avg);
}
