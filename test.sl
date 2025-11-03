function main() {
    o = new();

    o.add = 1;
    println(o.add);

    o.add = 2;
    println(o.add);

    o.x = 10;
    o.x = 11;
    println(o.x);

    k = "y";
    o[k] = 7;
    o[k] = 8;
    println(o[k]);
}
