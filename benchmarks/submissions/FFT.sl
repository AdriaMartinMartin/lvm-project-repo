function scale(){
  return 1000000; // defines number of fractional digits
}

function pi(){
  return 3141592;
}
function taylorTerms() {
  return 10;
}

function complexAdd(a, b) {
  result = new();
  result.re = a.re + b.re;
  result.im = a.im + b.im;
  return result;
}

function complexSub(a, b) {
  result = new();
  result.re = a.re - b.re;
  result.im = a.im - b.im;
  return result;
}

function complexMul(a, b) {
  result = new();
  result.re = (fpMul(a.re, b.re) - fpMul(a.im, b.im));
  result.im = (fpMul(a.re, b.im) + fpMul(a.im, b.re));
  return result;
}

function fpMul(a, b) {
  return (a * b) / scale();
}

function fpDiv(a, b) {
  return (a * scale()) / b;
}

function factorial(n) {
  if (n == 0) {
    return 1;
  } else {
    return (n * factorial(n-1));
  }
}

function pow(a, b) {
  result = 1;
  i = 0;
  while (i < b) {
    result = result * a;
    i = i + 1;
  }
  return result;
}

function floor(a) {
  return (a / scale()) * scale();
}

function mod(a, b) {
  q = floor(fpDiv(a, b));
  r = a - fpMul(q, b);
  return r;
}

function sin(x) {
  x = mod(x, 2*pi());
  if (x > pi()){
    x = x - 2 * pi();
  }
  if (x > pi() / 2) {
    x = pi() - x;
  }
  if (x < -pi() / 2) {
    x = -pi() -x;
  }
  term = x;
  sum = x;
  x_sq = fpMul(x, x);
  sign = -1;

  i = 1;
  while (i < taylorTerms()) {
   term = fpMul(term, x_sq);
   f = factorial(2*i + 1);
   term = term / f;
   sum = sum + sign * term;

   sign = -sign;
   i = i + 1;
  }
  return sum;
}

function cos(x) {
  x = mod(x, 2*pi());
  if (x > pi()){
    x = x - 2 * pi();
  }
  invert = false;
  if (x > pi()/2) {
    x = x-pi();
    invert = true;
  }
  if (x < -pi()/2) {
    x = x+pi();
    invert = true;
  }
  term = scale();
  sum = scale();
  x_sq = fpMul(x, x);
  sign = -1;

  i = 1;
  while (i < taylorTerms()) {
   term = fpMul(term, x_sq);
   f = factorial(2*i);
   term = term / f;
   sum = sum + sign * term;

   sign = -sign;
   i = i + 1;
  }

  if (invert) {
    return -sum;
  }

  return sum;
}

function fft(x) {
  N = getSize(x);
  if (N == 1) {
    return x;
  }

  even = new();
  odd = new();
  i = 0;
  while (i < N/2) {
    even[i] = x[2 * i];
    odd[i] = x[2 * i + 1];
    i = i + 1;
  }

  Feven = fft(even);
  Fodd = fft(odd);
  
  F = new();
  k = 0;
  while (k < N/2) {
    angle = fpDiv(2 * pi() * k, N * scale());
    w = new();
    w.re = cos(angle);
    w.im = -sin(angle);

    t = complexMul(w, Fodd[k]);
    F[k] = complexAdd(Feven[k], t);
    F[k + N/2] = complexSub(Feven[k], t);
    k = k + 1;
  }
  return F;
}

function check() {
  f = new();
  i = 0;
  while (i < 8){
    a = new();
    a.re = sin(fpMul(2 * pi(), fpDiv(i, 8)));
    a.im = 0;
    f[i] = a;
    i = i + 1;

  }
  F = fft(f);
  ref = new();
  ref1 = new();
  ref1.re = 0;
  ref1.im = -4 * scale();
  ref[1] = ref1;
  ref7 = new();
  ref7.re = 0;
  ref7.im = 4 * scale();
  ref[7] = ref7;
  ref0 = new();
  ref0.re = 0;
  ref0.im = 0;
  ref[0] = ref0;

  j=2;
  while (j < 7){
  
    a = new();
    a.re = 0;
    a.im = 0;
    ref[j] = a;
    j = j + 1;
  }

  error=0;
  k=0;
  while (k < 8){
    // println(k);
    if (ref[k].re != 0) {
      if (ref[k].im != 0) {

        error = error + fpDiv(fpMul(F[k].re - ref[k].re, F[k].re - ref[k].re) + fpMul(F[k].im - ref[k].im, F[k].im - ref[k].im), fpMul(ref[k].re, ref[k].re) + fpMul(ref[k].im, ref[k].im));
      }
    }
    k = k + 1;
  }
  // println(error);
}


function main() {
  check();
  ITERATIONS = 10000;
  MEASURE_FROM = 8000;
  NAME = "FFT";

  //
  // harness
  //
  time = 0;
  it = 0;

  while (it < ITERATIONS) {
    s = nanoTime();
      
    f = new();
    i = 0;
    while (i < 8){
      a = new();
      a.re = sin(fpMul(2 * pi(), fpDiv(i, 8)));
      a.im = 0;
      f[i] = a;
      i = i + 1;

    }
    F = fft(f);
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
