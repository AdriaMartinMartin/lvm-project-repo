/*
 * "computations" test
 * Test function: to test factorial computation
 */

function power(n, m)
{
  i = 1;
  r = n;
  while (i < m)
  {
    r = r * n;
    i = i + 1;
  }
  return r;
}


function main()
{
  println(power(3, 2));
  println(power(3, 3));
  println(power(2, 3));
  println(power(2, 4));
  println(power(2, 10));
}
