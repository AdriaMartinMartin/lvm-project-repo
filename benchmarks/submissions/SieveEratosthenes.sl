// Sieve of Eratosthenes benchmark, 
// counting the number of primes up to num
function sieve(num) { 
  prime = new();
  i = 0;
  while(i <=num){
    prime[i] = 1;
    i=i+1;
  }
  p = 2;
  while(p*p<=num){
    if(prime[p] == 1){
      i = p*p;
      while(i<=num){
        prime[i] = 0;
        i= i+p;
      }
    }
    p=p+1;
  }
  i = 2;
  count = 0;
  while(i<=num){
    if(prime[i] == 1){
      count = count + 1;
    }
    i=i+1;
  }
  return count;

}

//function that returns the multiple of two vectors each size num 
//and each with all elements being of value 5

function vectorMulti(num){

  x1 = new();
  x2 = new();
  i = 0;
  while(i<num){
    x1[i] = 5;
    x2[i] = 5;
    i = i+1;
  }
  j = 0;
  sum = 0;
  while(j<num){
    sum = sum + x1[j]*x2[j];
    j = j + 1;
  }
  return sum;

}
//returns the count of the number of points of the mandelbrot set we have found in the grid of points the size of widthx * heighty.
//Its very rough as the language doesnt support floating point numbers
function mandelbrot(widthx,heighty,maxiteration){
    count = 0;
    scale = 100;
    x0 = 0;
    y0 = 0;
    dx = 0;
    dy = 0;
    x = 0;
    y = 0;
    iter = 0;
    while(dx<=widthx){

      dy = 0;
      while(dy<=heighty){
        
        x0 = -2*scale + 3*scale*dx/widthx;
        
        y0 = -1*scale + 3*scale*dy/heighty;
        x = 0;
        y = 0;
        iter = 0;

        while(x*x + y*y <= 4*scale*scale && iter< maxiteration){
          xtemp = 0;
          xtemp = x*x - y*y + x0;
          ytemp = 0;
          ytemp = 2*x*y + y0;
          x = xtemp;
          y = ytemp;
          iter = iter + 1;
        }
        if(iter == maxiteration){
          count = count + 1;
        } 
        dy = dy + 1;
      }
      dx = dx + 1;
    }
    return count;

}

function benchmark() {
  
  //
  // Test that the benchmark result is correct
  //
  //Sieve test

  f = sieve(1000);
  if (f != 168) {
    println("Benchmark failed at level Sieve");
  }
  // VectorMulti test

  f = vectorMulti(1000);
  if(f!=25000){
    println("Benchmark failed at level Vector");
  }
  // Mandelbort test
  f = mandelbrot(300,300,100);
  if(f<=0){
    println("Benchmark failed at level Mandelbrot");
  }
}  

function main() {
  //
  // benchmark constants
  //
  ITERATIONS = 10000;
  MEASURE_FROM = 8000;
  NAME = "SieveEratosthenes";

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
