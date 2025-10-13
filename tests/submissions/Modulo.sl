// "computations"
function modulo(dividend, divisor){
    return dividend - (dividend / divisor) * divisor;
}

function main(){
    println(modulo(105, 10));
    println(modulo(100, 10));
    println(modulo(100, 1));
    println(modulo(159583720201222, 30309));
    println(modulo(159583720201222, 159583720201222));
    println(modulo(1, 1));
}


