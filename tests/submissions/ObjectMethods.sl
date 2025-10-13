// CATEGORY: objects/arrays

function double(x) {
  return x * 2;
}

function add(a, b) {
  return a + b;
}

function main() {
  calculator = new();
  calculator.double = double;
  calculator.add = add;
  calculator.result = 0;
  
  calculator.result = calculator.double(5);
  println(calculator.result);
  
  calculator.result = calculator.add(calculator.result, 3);
  println(calculator.result);
  
  operation = calculator.double;
  println(operation(7));
  
  final = calculator.add(calculator.double(4), calculator.double(6));
  println(final);
  
  if (calculator.result != 13) {
    println("ERROR: calculator result wrong");
  }
}
