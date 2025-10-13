// unit test for objects (objects/arrays)

function main() {
    obj = new();
    obj["a"] = "something";
    obj["b"] = 11;
    obj["nest"] = new();
    obj["nest"]["c"] = 2;
    obj["nest"]["d"] = true;

    tags = new();
    tags[0] = "a";
    tags[1] = "b";
    tags[2] = "nest";

    i = 0;
    clone = new();
    while(i < getSize(tags)) {
        tag = tags[i];

        if(tag == "nest") {
            clone[tag] = new();
            clone[tag]["c"] = obj[tag]["c"];
            clone[tag]["d"] = obj[tag]["d"];
        } else {
            clone[tag] = obj[tag];
        }
        i = i + 1;
    }

    println("a: " + clone["a"]);
    println("b: " + clone["b"]);
    println("nest: ");
    println("   c: " + clone["nest"]["c"]);
    println("   d: " + clone["nest"]["d"]);

    println(obj == clone);

    shallow = obj;

    println(shallow == obj);
}