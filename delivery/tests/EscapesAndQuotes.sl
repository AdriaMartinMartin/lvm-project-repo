/* EscapesAndQuotes.sl                             [strings]
 *
 * This unit tests will assert:
 *  - Different combinations of quotes, doubles and simples.
 *  - See if exists control characters like escape sequences.
 *  - Double-quoted strings don't support escape sequences.
 *  - If quotes are embedded with \" and backslashes with \\.
 */
function main() {
    println("Hello World!");                                // Hello World
    // println('Hello World!');                             // Error(s) parsing script :(
    // println(`Hello World!`);                             // Error(s) parsing script :(

    println("He said; 'Hello!'");                           // He said; 'Hello!'
    println("He said; `Hello!`");                           // He said; `Hello!`
    // println('He said; "Hello!"');                        // Error(s) parsing script :(

    // println("He said; 'I saw him saying: "Hello"'");     // Error(s) parsing script :(

    // println("
    //     Hello World!                                     // Error(s) parsing script :(
    // ");
    println("\nHello World!\n");                            // \nHello World!\n
    // println("Hello\tWorld!")                             // Error(s) parsing script :(
    // println(`\nHello World!\n`);                         // Error(s) parsing script :(
    println();                                              // NULL
    println("");                                            //
    println("Hello World!");                                // Hello World!
    println("");                                            //

    // println(""Hello World!"");                           // Error(s) parsing script :(
    // println("\"Hello World!\"");                         // Error(s) parsing script :(
    println("C:\\Users\\");                                 // C:\\Users\\
}