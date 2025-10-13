function main(){
    s = "abcdef";

    if("abcdef" == ("" + s)){
        println(true);
    }

    if("abcdef" == (s + "")){
        println(true);
    }
}