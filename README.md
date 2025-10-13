# VM Course 2025 (2IMD20) Project folder

This repository contains the basic code and tests for the programming language VM that you will have to develop in the project.

The repository contains the following folders:

* `./reference-impl`: the reference implementation (RI) for the language that you will implement.
* `./vm-skeleton`: the starting point for your project.
* `./tests`: the unit tests for the language. You will contribute more tests.
* `./benchmarks`: performance benchmarks for the project. You will contribute more benchmarks.

# Running the unit tests

To run the RI unit tests, you can use the `test_all.sh` bash script with the `sl` executable:
```
$ ./test_all.sh ./reference-impl/sl
```
Note that in this case we are using `./reference-impl`, while you will have to test your code against `./vm-skeleton/sl`.

All tests pass on the RI, and the output should look like:
```
[OK] Output for ./tests/Ackermann matches expected output.
[OK] Output for ./tests/Add matches expected output.
[OK] Output for ./tests/Arithmetic matches expected output.
[OK] Output for ./tests/ArrayLike matches expected output.
[OK] Output for ./tests/Break matches expected output.
...
...
[OK] Error output for ./tests/UndefinedFunction03 matches expected error.
========== ALL DONE ==========
  tests passed: 57
  tests failed: 0
```

The actual number of unit tests will change during the VM course, so `57` is just an example.

# Helper

While building the bytecode compiler, it might be nice to see how the AST looks like.
To help you visualise the AST, the `-dump-ast` flag and the `prettify.py` script are now available.

You can use them inside the docker like so:
```
./toy ../tests/Emoji.sl -dump-ast | ../prettify.py
```

Note that the script is mostly LLM generated, so it might break in some edge cases. Still, it can be useful if you are unsure why some nodes are not being visited.

Example output for the `FunctionRedefinitionDuringExecution.sl` test:

```
ToyBlockNode
  functionName: 'greet'
  statements:
  - ToyInvokeNode
    functionNode: ToyFunctionLiteralNode
      name: 'println'
    toyExpressionNodes:
  - ToyStringLiteralNode
    value: 'Hello!'

------------------------------------------------------

ToyBlockNode
  functionName: 'main'
  statements:
  - ToyInvokeNode
    functionNode: ToyFunctionLiteralNode
      name: 'greet'
    toyExpressionNodes:
  - ToyInvokeNode
    functionNode: ToyFunctionLiteralNode
      name: 'defineFunction'
    toyExpressionNodes:
  - ToyStringLiteralNode
      value: 'function greet() { println(42); }'
  - ToyInvokeNode
    functionNode: ToyFunctionLiteralNode
      name: 'greet'
    toyExpressionNodes:
```
