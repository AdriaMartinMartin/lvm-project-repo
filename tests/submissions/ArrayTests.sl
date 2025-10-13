function array_test() {
        // Test array creation and accessing array values
        arr = new();
        arr[0] = "hello world";
        arr[1] = -99;
        arr[2] = new();

        index = 3;
        while (index < 20) {
                arr[index] = index;
                index = index + 1;
        }

        return arr;

}

function main() {
        arr = array_test();
        index = 0;
        while (index < 20) {
                println(arr[index]);
                index = index + 1;
        }
}