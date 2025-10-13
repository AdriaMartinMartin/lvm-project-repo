// others

function main() {
    i = 0;
    sum = 0;
    while(i<5) {
        j = 0;
        while(j < 10) {
            if(j == 2 || j == 4) {
                j = j + 1;
                continue;
            }
            sum = sum + (i + j);
            println("(i, j) = (" + i + ", " + j + ")");
            if(j == 6) {
                break;
            }
            j = j + 1;
        }
        if(i == 3) {
            break;
        }
        i = i + 1;
    }

    println(sum);
}