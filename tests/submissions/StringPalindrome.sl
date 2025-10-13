/*
 * Test 2 strings
 */

function toString(str){
  return "" + str;
}

function isStringPalindrome(str)
{

    size = getSize(toString(str));

    if (size <= 1) {
        return true;
    }

    left = 0;
    right = size - 1;

    while (left < right) {
        leftChar = subString(str, left, left + 1);
        rightChar = subString(str, right, right + 1);

        if (leftChar != rightChar) {
            return false;
        }

        left = left + 1;
        right = right - 1;
    }

    return true;
}

function main()
{
    println(isStringPalindrome("madam")); // expected true
    println(isStringPalindrome("racecar")); // expected true
    println(isStringPalindrome("level")); // expected true
    println(isStringPalindrome("hello")); // expected false
    println(isStringPalindrome("andreea")); // expected false
    println(isStringPalindrome("world")); // expected false
    println(isStringPalindrome("a")); // expected true
    println(isStringPalindrome("100")); // expected false
    println(isStringPalindrome("101")); // expected true
    println(isStringPalindrome("")); // expected true
}