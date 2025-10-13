/* RecursiveObjectMethod.sl                                                   [objects/arrays]
 * This unit test asserts that:: recursive calls via object field; parameter carries iteration.
 */

function recursive(obj, it) {
    if (it >= 10) { obj.fn = NULL; obj.status = "ok"; return "ok"; }

    println("[" + it + "/10] Step completed.");
    return obj.fn(obj, it + 1);
}

function main() {
    obj = new();
    obj.fn = recursive;

    res = obj.fn(obj, 0);
    println(obj.status);
    println(res);
}