/* ParserVariableNames.sl                          [other]
 *
 * This unit test asserts the limits on the variable names
 * for the toy/sl languages; how they start, if they allow
 * special characters...
 */

function main() {
    a = 1;
    A = 2;
    _ = 3;
    $ = 4;
    abc123 = 5;
    _var2 = 6;
    $dollarName = 7;
    camelCase = 8;
    snake_case_name = 9;
    CAPSLOCK = 10;
    MiXeD123 = 11;
    with$sign = 12;
    __doubleUnderscore = 13;
    $$_money = 14;
    null = 15;

    println(a);
    println(A);
    println(_);
    println($);
    println(abc123);
    println(_var2);
    println($dollarName);
    println(camelCase);
    println(snake_case_name);
    println(CAPSLOCK);
    println(MiXeD123);
    println(with$sign);
    println(__doubleUnderscore);
    println($$_money);
    println(null);

    // INVALID identifiers (uncomment -> parse errors)
    // 123abc = 1;          // starts with digit
    // 0xVar = 2;           // starts with digit
    // my-var = 3;          // TypeError -> thinks is an operation.
    // hello! = 4;          // '!' not allowed
    // @decorator = 5;      // '@' not allowed
    // foo#bar = 6;         // '#' not allowed
    // name%id = 7;         // '%' not allowed
    // space name = 8;      // whitespace not allowed
    // accentedÉ = 9;       // é not allowed (non-ASCII)
    // var😊 = 10;          // emoji not allowed
    // 😀face = 11;         // emoji not allowed
    // name*star = 12;      // TypeError -> thinks is an operation.
    // break = 13;          // keyword
    // if = 14;             // keyword
    // while = 15;          // keyword
    // function = 16;       // keyword
    // return = 17;         // keyword
    // true = 19;           // literal, not allowed as name
    // false = 20;          // literal, not allowed as name
}