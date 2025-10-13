// Object test

function show(obj) {
    println("Object " + obj + " has value: " + obj.value);
}

function its_that_time(obj) {
    obj.value = 420;
}

function merge_objects(obj1, obj2) {
    obj3 = new();
    obj3.value = obj1.value * 1000 + obj2.value;
    return obj3;
}
 
function main() {
    nice = new();
    nice.value = 69;

    show(nice);

    also_nice = new();
    its_that_time(also_nice);

    show(also_nice);

    nicest = merge_objects(nice, also_nice);

    show(nicest);

}