// This code solves the connect ropes with minimum cost problem. You can read more about this problem on https://www.geeksforgeeks.org/dsa/connect-n-ropes-minimum-cost/

function constructHeap(){
  heap = new();
  heap.size = 0;
  return heap;
}

function heapifyUp(heap){
  index = heap.size - 1;
  while (index > 0) {
      parentIndex = (index - 1) / 2;
      if (
          heap[index] >=
          heap[parentIndex]
      ) {
          break;
      }
      up = heap[index];
      heap[index] = heap[parentIndex];
      heap[parentIndex] = up;
      index = parentIndex;
  }
  return heap;
}

function heapifyDown(heap) {
  index = 0;
  size = heap.size;
  while (true) {
    leftChild = 2 * index + 1;
    rightChild = 2 * index + 2;
    smallest = index;

    if (
        leftChild < size &&
        heap[leftChild] <
        heap[smallest]
    ) {
        smallest = leftChild;
    }

    if (
        rightChild < size &&
        heap[rightChild] <
        heap[smallest]
    ) {
        smallest = rightChild;
    }

    if (smallest == index) {
        break;
    }
    down = heap[index];
    heap[index] = heap[smallest];
    heap[smallest] = down;
    index = smallest;
  }
  return heap;
}

function insertRopeInHeap(heap, rope){
  heap[heap.size] = rope;
  heap.size = heap.size + 1;
  return heapifyUp(heap);
}

function insertRopesInHeap(ropes){ 
  heap = constructHeap();
  i = 0;
  while(i < getSize(ropes)){
    heap = insertRopeInHeap(heap, ropes[i]);
    i = i + 1;
  }
  return heap;
}

function popRopeFromHeap(heap){
  if (heap.size == 1) {
    heap.size = 0;
    return heap[0];
  }
  root = heap[0];
  heap[0] = heap[heap.size - 1];
  heap.size = heap.size - 1;
  return root;
}

function minCost(ropes) {
    heap = insertRopesInHeap(ropes);
    res = 0;

    while (heap.size > 1) {
        // Extract shortest two ropes from pq
        first = popRopeFromHeap(heap);
        heapifyDown(heap);

        second = popRopeFromHeap(heap);
        heapifyDown(heap);

        // Connect the ropes: update result and
        // insert the new rope to pq
        res = res + (first + second);
        insertRopeInHeap(heap, (first + second));
    }

    return res;
}

function benchmark() {
  ropes = new();
  ropes[0] = 5;
  ropes[1] = 210;
  ropes[2] = 19;
  ropes[3] = 6;
  ropes[4] = 9;
  ropes[5] = 3;
  ropes[6] = 2;
  ropes[7] = 56;
  ropes[8] = 78;
  ropes[9] = 15;
  ropes[10] = 5;
  ropes[11] = 12;
  ropes[12] = 4;
  ropes[13] = 99;
  ropes[14] = 62;
  ropes[15] = 91;
  ropes[16] = 33;
  ropes[17] = 21;
  ropes[18] = 56;
  ropes[19] = 78;
  ropes[20] = 98;
  ropes[21] = 12;
  answer = minCost(ropes);
  //
  // Test that the benchmark result is correct
  //
  if (answer != 3620) {
  //   println("Benchmark suc6!");
  //   println("The computed anwser is: " + answer);
  //   println("The correct anwser is: " + 3620);
  // }
  // else{
    println("Benchmark failed");
    println("The computed answer is: " + answer);
    println("The correct anwser is: " + 3620);
  }
}  

function main() {
  //
  // benchmark constants
  //
  ITERATIONS = 10000;
  MEASURE_FROM = 8000;
  NAME = "Connect n ropes with minimum cost";

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