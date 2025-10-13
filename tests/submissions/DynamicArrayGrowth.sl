/*
 * Objects/Array: Testing the dynamic building of an array
 */

function main() {
    arr = new();
    
    arr[0] = 100;
    arr[1] = "hello";
    arr[2] = new();
    arr[2].msg = "nested";
    
    printArray(arr);
    
    arr[3] = true;
    arr[4] = new();
    arr[4].info = "new object";
    arr[5] = 3;

    printArray(arr);

    arr[100] = true;

    println(arr[100]);

    i = 0; 
    while (i < getSize(arr)) {
        arr[i] = i * i;
        i = i + 1;
    }

    printArray(arr);
    
}

function printArray(arr) {
    i = 0;
    while (i < getSize(arr)) {
        println("arr[" + i + "] = " + arr[i]);
        i = i + 1;
    }
}
