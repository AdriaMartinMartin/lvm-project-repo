function hanoi(n, from, aux, to) {
    moves = 0;
  if (n == 1) {
    println(from + " -> " + to);
    moves = moves + 1;
    return 0;
  }
  hanoi(n - 1, from, to, aux);
  println(from + " -> " + to);
  moves = moves + 1;
  hanoi(n - 1, aux, from, to);
  return 0;
}



function main(){
    n = 3;
    src = "A";
    aux = "B";
    dst = "C";

    
    hanoi(n, src, aux, dst);
    
   
}