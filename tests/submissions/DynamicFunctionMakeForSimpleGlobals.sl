// 'other' tests (dynamic functions)
function null() {}
function setFunction(expression) {
    defineFunction("function test(a,b) {" + expression + " }");
}
function setConstant(name,data) {
    defineFunction("function "+name+"() { return " + data + ";}");
}


function addToZ(n) {
    setConstant("z", z()+n);
    if (z() > 15) {
        setConstant("halt", "true");
    }
}

function main() {
    setFunction("while (a <= b) { a = a+1; if(a == b-2) { continue;} println(a); }" );
    test(1,5);

    setupConstants();
    println("x="+x());
    println("y="+y());
    test(x(), y());
    i = 1;
    while (i > 0) {
        // scope defined globals escape the scope :)
        addToZ(i);
        if (halt()) {
            break;
        }
        i = i + 1;
    }
    println("i="+i);
    println("z="+z());
    setConstant("z", "null()");
    println("z="+z());
}

function setupConstants(){
    setConstant("halt", "false");
    setConstant("x", 15);
    setConstant("y", 20);
    setConstant("z", 0);
}
