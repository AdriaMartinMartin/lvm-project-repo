function main(){
    reps = 50;
    i = 0;
    s = "";
    while(i < reps){
        s = s + "ab";
        i = i + 1;
    } 

    if(getSize(s) == 100){
        println(true);
    }

    t = "ababababab";
    if(getSize(t) == 10){
        println(t);
    }
}