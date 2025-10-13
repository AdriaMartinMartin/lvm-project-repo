// write at high index, avoid reading holes

function main(){
    a = new();
    a[0] = 1;
    a[5] = 6;
    a[1314] = 7;

    sum = a[0] + a[5] + a[1314];

    //sum -> 14
    println(sum);
}