/* WhileLoopArrayVsObject.sl                                 [objects/arrays]
 *
 * This unit test asserts that:
 *   - A while loop can traverse arrays via numeric index.
 *   - The same pattern works with objects if the keys are stored in an array.
 *   - Demonstrates the difference: arrays have implicit numeric ordering,
 *     objects require an explicit list of keys.
 */

 function main() {
     arr = new();
     arr[0] = "a";
     arr[1] = "b";
     arr[2] = "c";
     println(getSize(arr));             // 3

     i = 0;
     while (i < 3) {
         println(arr[i]);               // a b c
         i = i + 1;
     }

     obj = new();
     obj.x = 1;
     obj.y = 2;
     obj.z = 3;
     println(getSize(obj));             // 3

     keys = new();
     keys[0] = "x";
     keys[1] = "y";
     keys[2] = "z";
     obj.keys = keys;
     println(getSize(obj.keys));        // 3

     j = 0;
     while (j < getSize(obj.keys)) {
         k = obj.keys[j];
         println(obj[k]);               // 1 2 3
         j = j + 1;
     }
 }