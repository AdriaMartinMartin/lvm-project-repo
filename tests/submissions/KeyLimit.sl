// unit test for objects (objects/arrays)

function main() {
    obj = new();
    obj["first name"] = "first";
    obj["last-name"] = "last";
    
    println(obj["first name"]);
    println(obj["last-name"]);

    tree = new();
    tree["a"] = new();
    tree["a"]["b"] = new();
    tree["a"]["b"][0] = 1;
    tree["a"]["b"][1 + 1] = 3;

    println(tree["a"]["b"][0]);
    println(tree["a"]["b"][2]);

    a = tree["a"]["b"];
    a[1] = "2";

    println(tree["a"]["b"][1]);

    a["key@!@#$%^&*()-+_='|\{}[]<>,./1"] = "value@1";
    println(a["key@!@#$%^&*()-+_='|\{}[]<>,./1"]);
}