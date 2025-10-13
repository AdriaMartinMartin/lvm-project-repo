/*
 * Test type: Objects/Arrays
 */

function main() {
   a = new();
   a.i = 0;

   i = 0;
   N = 10;
   while (i < N) {
      prev = a;
      a = new();
      a.i = i;

      println((a == prev) + " " + prev.i + " " + a.i);

      i = i + 1;
   }
}
