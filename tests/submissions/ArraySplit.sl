// unit test for arrays (objects/arrays)

function printArr(arr) {
    i = 0;
    while(i < getSize(arr)) {
        println(arr[i]);
        i = i + 1;
    }
}

function main() {
    arr = new();
    arr[0] = 1;
    arr[1] = 2;
    arr[2] = 3;
    arr[3] = 4;
    arr[4] = 5;
    arr[5] = 6;

    i = 0;
    arr1 = new();
    arr2 = new();

    while(i < getSize(arr)) {
        halfPoint = getSize(arr) / 2;
        if(i < halfPoint) {
            arr1[i] = arr[i];
        } else {
            arr2[i - halfPoint] = arr[i];
        }
        i = i + 1;
    }

    printArr(arr1);
    println("");
    printArr(arr2);

    original = new();
    i = 0;
    while(i < getSize(arr1)) {
        original[i] = arr1[i];
        original[getSize(arr1) + i] = arr2[i];
        i = i + 1;
    }

    println("");
    printArr(original);
}