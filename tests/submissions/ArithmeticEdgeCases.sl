function main(){
    x = 123456;
    if (x + 0 != x) { 
        println("FAIL: x+0"); 
    }else{
        println(true);
    }
    if (x * 0 != 0) { 
        println("FAIL: x*0"); 
        }else{
            println(true);
    }

    if (100 / 10 / 2 != 5) { 
        println("FAIL: left-assoc division"); 
        }else{
            println(true);
        }
    
    if (100 / (10 / 2) != 20) { 
        println("FAIL: paren division"); 
        }else{
            println(true);
        }

    if (100 - 30 - 20 != 50) { 
        println("FAIL: left-assoc subtraction"); 
        }else{
            println(true);
        }
    
     if (100 - (30 - 20) != 90) { 
        println("FAIL: paren subtraction"); 
        }else{
            println(true);
        }

    if (2 + 3 * 4 != 14) { 
        println("FAIL: precedence * over +"); 
        }else{
            println(true);
        }
    if ((2 + 3) * 4 != 20) { 
        println("FAIL: paren changes precedence"); 
        }else{
            println(true);
        }
}