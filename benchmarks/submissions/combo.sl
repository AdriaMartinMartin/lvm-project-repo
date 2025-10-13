function loop(k, l) {
    i = 0;
    sum = 0;
    while(i < k) {
        j = 0;
        while(j < l) {
            sum = sum + i + j;
            j = j + 1;
        }
        i = i + 1;
    }
    return sum;
}

function setGet(m) {
    obj = new();
    i = 0;
    while(i < m) {
        key = "key_" + i;
        obj[key] = i;
        i = i + 1;
    }
    sum = 0;
    i = 0;
    while(i < m) {
        key = "key_" + i;
        sum = sum + obj[key];
        i = i + 1;
    }
    return sum;
}

function bubbleSort(arr) {
    n = getSize(arr);
    sorted = false;
    i = 0;
    while(sorted == false) {
        swap = false;
        j = 0;
        while(j < n - i - 1) {
            if(arr[j] > arr[j+1]) {
                aux = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = aux;
                swap = true;
            }
            j = j + 1;
        }
        if(swap == false) {
            sorted = true;
        } else {
            i = i + 1;
        }
    }
    return arr[0] + arr[1] + arr[n-1];
}

function bubbleSortExpectedSum(n) {
    mid = n/2;
    return 1 + 2 + (mid + 1) + n;
}

function initArr(n) {
    arr = new();
    i = 0;
    while(i < n) {
        arr[i] = n - i;
        i = i + 1;
    }
    return arr;
}

function split(o) {
    s = "one two three four  five six ";
    sum = 0;
    i = 0;
    while(i<o) {
        arr = stringSplit(s);
        sum = sum + getSize(arr);
        i = i + 1;
    }
    return sum;
}

function splitExpectedSum(o) {
    return 7 * o;
}

function dotProduct(p) {
    a = new();
    b = new();
    i=0;
    while(i<p) {
        a[i] = i;
        b[i] = p-1;
        i = i + 1;
    }
    sum = 0;
    i = 0;
    while(i<p) {
        sum = sum + a[i] * b[i];
        i = i + 1;
    }
    return sum;
}

function loopMain(k, l) {
    sum = loop(k, l);
    if(sum != 999000000) {
        return false;
    }
    return true;
}

function setGetMain(m) {
    sum = setGet(m);
    if(sum!=124750) {
        return false;
    }
    return true;
}

function bubbleSortMain(n) {
    arr = initArr(n);
    sum = bubbleSort(arr);
    if(sum != 503) {
        return false;
    }
    return true;
}

function splitMain(o) {
    sum = split(o);
    if(sum!=splitExpectedSum(o)) {
        return false;
    }
    return true;
}

function dotProductMain(p) {
    sum = dotProduct(p);
    if(sum != 490050) {
        return false;
    }
    return true;
}

function mainBenchmark(k, l, m, n, o, p) {
    checkFail(loopMain(k, l));
    checkFail(setGetMain(m));
    checkFail(bubbleSortMain(n));
    checkFail(splitMain(o));
    checkFail(dotProductMain(p));
}

function checkFail(success) {
    if(success == false) {
        println("Benchmark failed");
    }
}

function main() {
    TOTAL = 100;
    MEASURE_FROM = 80;
    i = 0;
    time = 0;
    k = 1000;
    l = 1000;
    m = 500;
    n = 500;
    o = 1000;
    p = 100;
    while(i < TOTAL) {
        s = nanoTime();
        mainBenchmark(k,l,m,n,o,p);
        e = nanoTime() - s;
        if(i >= MEASURE_FROM) {
            time = time + e;
        }
        i = i + 1;
    }
    avg = time / (TOTAL-MEASURE_FROM);
    println("Combo: " + avg);
}