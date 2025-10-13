// CATEGORY: objects/arrays

function main() {
  stack = new();
  stack.top = 0;
  
  stack[0] = 10;
  stack.top = stack.top + 1;
  stack[1] = 20;
  stack.top = stack.top + 1;
  stack[2] = 30;
  stack.top = stack.top + 1;
  
  println(stack.top);
  
  stack.top = stack.top - 1;
  println(stack[stack.top]);
  stack.top = stack.top - 1;
  println(stack[stack.top]);
  
  stack[stack.top] = 40;
  stack.top = stack.top + 1;
  
  println(stack.top);
  stack.top = stack.top - 1;
  println(stack[stack.top]);
  stack.top = stack.top - 1;
  println(stack[stack.top]);
  
  if (stack.top != 0) {
    println("ERROR: stack should be empty");
  }
}