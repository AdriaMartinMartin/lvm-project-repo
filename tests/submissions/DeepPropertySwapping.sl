// Other

function main() {
    x = new();
    x.y = new();
    x.y.x = x;
    println(x.y.x == x);
    println(x.y.x.y == x.y);
    z = new();
    x.y = z;
    z.z = z;
    println(x.y.z == z);
    println(z.z.z == z);
    println(x.y.x);
}