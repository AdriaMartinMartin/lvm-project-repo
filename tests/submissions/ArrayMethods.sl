// "object/arrays" (some higherorder functions on arrays)

function map(arr, fn) {
    res = new();
    i = 0; 
    while(i < getSize(arr)) {
        res[i] = fn(arr[i]);
        i = i + 1;
    }
    return res;
}

function foldr(arr, fn, acc) {
    res = acc;
    i = 0; 
    while(i < getSize(arr)) {
        res = fn(arr[i], res);
        i = i + 1;
    }
    return res;
}
function foldl(arr, fn, acc) {
    res = acc;
    i = 0; 
    while(i < getSize(arr)) {
        res = fn(res, arr[i]);
        i = i + 1;
    }
    return res;
}

function add(x,y)   {   return x + y;       }
function sub(x,y)   {   return x - y;       }
function mult(x,y)  {   return x * y;       }
function inc(x)     {   return add(x,1);    }
function dec(x)     {   return sub(x,1);    }
function mod(x, y)     { while(y <= x) {x = x-y;} return x; }
function double(x)  {   return mult(x,2);   }
function doubleOdd(x) {
    if (mod(x,2) == 0) {
        return x;
    }
    return double(x);
}

function main() {
    arr = new();
    i = 0; 
    while (i < 10) {
        arr[i] = i;
        i = i + 1;
    }
    printArray(arr, ", ");
    printArray(map(arr,double), ", ");
    printArray(map(arr,inc), ", ");
    printArray(map(arr,dec), ", ");
    printArray(map(arr,doubleOdd), ", ");
    println(foldr(arr,add, 0));
    println(foldl(arr,add, 0));
    println(foldr(arr,sub, 50));
    println(foldl(arr,sub, 50));
}

function printArray(array, delimiter) {
	strBuilder = "";
	i = 0;
	while(i < getSize(array)) {
		strBuilder = strBuilder + array[i];
		i = i + 1;
		if (i != getSize(array)) {
			strBuilder = strBuilder + delimiter;
		}
	}
	println(strBuilder);
}
