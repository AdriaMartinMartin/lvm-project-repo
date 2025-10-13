/*
 * Type of test: arrays
 */

function printArray(arr) {
    i = 0;
    line = "[";
    while (i < getSize(arr)) {
        line = line + arr[i];
        if (i < getSize(arr) - 1) {
            line = line + ", ";
        }
        i = i + 1;
    }
    line = line + "]";
    println(line);
}

function sortArray(arr) {
    n = getSize(arr);
    if (n <= 1) {
        return arr;
    }

    i = 0;
    while (i < n - 1) {
        j = 0;
        while (j < n - i - 1) {
            if (arr[j] > arr[j + 1]) {
                temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
            }
            j = j + 1;
        }
        i = i + 1;
    }
    return arr;
}

function main() {
    arr1 = new();
    
    arr1[0] = 7;
    arr1[1] = 2;
    arr1[2] = 5;
    arr1[3] = 3;
    arr1[4] = 13;
    arr1[5] = -201;
    arr1[6] = 9;
    arr1[7] = 50;

    arr2 = new();
    arr2[0] = "x";
    arr2[1] = 3;
    arr2[2] = true;

    printArray(arr1);
    sortArray(arr1);
    printArray(arr1);

    sortArray(arr2);
}