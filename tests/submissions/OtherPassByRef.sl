// This is a test for the other category
// Tests passing objects by reference

function modifier(obj) {
    obj.field = "updated";
}

function main () {
    obj = new();
    obj.field = "old";
    println(obj.field);
    modifier(obj);
    println(obj.field);
}
