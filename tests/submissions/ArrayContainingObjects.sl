/*
 * Objects/Array: Testing array containing objects. 
 */

function main() {
    arr = new();
    
    i = 0;
    while (i < 5) {
        elem = new();
        elem.index = i;
        elem.square = i * i;
        arr[i] = elem;
        i = i + 1;
    }

    i = 0;
    while (i < 5) {
        if (arr[i].index != i) {
            println("ERROR: value of arr[" + i + "].index is " + arr[i].index + ", but should be " + i);
        }

        if (arr[i].square != i * i) {
            println("ERROR: value of arr[" + i + "].square is " + arr[i].square + ", but should be " + (i*i));
        }
        
        println("arr[" + i + "] -> index: " + arr[i].index + ", square: " + arr[i].square);
        i = i + 1;
    }
}
