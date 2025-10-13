/*
 * Test 1 other
 */

function null()
{

}

function Node(value, left, right) {
  node = new();
  node.value = value;
  node.left = left;
  node.right = right;

  return node;
}

function makeTreeWithDepth(depth) {
  if (depth == 0)
  {
    return Node(1, null(), null());
  }

  return Node(1, makeTreeWithDepth(depth - 1), makeTreeWithDepth(depth - 1));
}

function countTreeNodes(tree) {
  if (tree == null())
  {
    return 0;
  }
  return 1 + countTreeNodes(tree.left) + countTreeNodes(tree.right);
}

function main() {
  depth1 = 2;
  tree1 = makeTreeWithDepth(depth1);
  println(countTreeNodes(tree1)); // expect: 2097151

  depth2 = 5;
  tree2 = makeTreeWithDepth(depth2);
  println(countTreeNodes(tree2)); // expect: 67108863

  tree3 = null();
  println(countTreeNodes(tree3));
}

