// 'other'  (recursion with a binary tree)

function null() {}

function makeNode(data) {
    n = new();
    n.left = null();
    n.right = null();
    n.data = data;
    return n;
}

function sum(node) {
    if (node == null()){
        return 0;
    }
    res = node.data;
    if (node.left != null()) {
        res = res + sum(node.left);
    }
    if (node.right != null()) {
        res = res + sum(node.right);
    }
    return res;
}

function preOrderWalk(node, fn) {
    if (node == null()) {
        return;
    }
    fn(node);
    preOrderWalk(node.left, fn);
    preOrderWalk(node.right, fn);
}
function double(node) {
    println("node data: '"+ node.data+"'");
    node.data = node.data + node.data;
}
function makeFullTree(depth) {
    if (depth == 0) {
        return null();
    }
    n = makeNode(depth);
    n.right = makeFullTree(depth - 1);
    n.left = makeFullTree(depth - 1);
    return n;
}

function main() {
    root = makeNode(15);
    root.left = makeNode(4);
    root.left.left = makeNode(3);
    root.left.right = makeNode(9);
    root.left.right.right = makeNode(10);
    root.right = makeNode(20);
    root.right.right = makeNode(25);
    root.right.right.left = makeNode(22);
    root.right.right.left.right = makeNode(24);

    println(sum(root));
    preOrderWalk(root,double);
    println(sum(root));

    strTree = makeNode("This");
    strTree.left = makeNode("is");
    strTree.left.right = makeNode("a");
    strTree.right = makeNode("binary");
    strTree.right.left = makeNode("tree");

    println(sum(strTree));
    println(sum(null()));

    full5 = makeFullTree(5);
    println(sum(full5));

    full15 = makeFullTree(15);
    println(sum(full15));

}
