// test performing computation

function pascalsTriangle(n) {
    row = new();
    i = 0;

    while(i < n + 1) {
        row[i] = new();
        j = 0;
        while(j < i + 1) {
            if(j == 0) {
                row[i][j] = 1;
            } else {
                if(j == i) {
                    row[i][j] = 1;
                } else {
                    row[i][j] = row[i-1][j-1] + row[i-1][j];
                }
            }
            j = j + 1;
        }
        i = i + 1;
    }

    return row;
}

function main() {
    n = 10;
    row = pascalsTriangle(n);

    i = 0;
    while(i < n + 1) {
        j = 0;
        s = "";
        while(j < n - i) {
            s = s + "   ";
            j = j + 1;
        }
        j = 0;
        while(j < i + 1) {
            s = s + row[i][j] + "    ";
            j = j + 1;
        }
        println(s);
        i = i + 1;
    }
}