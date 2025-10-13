//empty string, boundary substrings, concat with""


function main() {
    s = "abcdef";
     if ("" + s != "abcdef") 
     { 
        println("FAIL: empty concat"); 
     }else{
        println(true);
     }

     if ("ab" + "cdef" != s) { 
        println("FAIL: ab+cdef"); 
        }else{
            println(true);
        }



     if ("a" + "b" + "c" + "def" != s) 
     { 
        println("FAIL: segmented concat");
      }else{
        println(true);
      }

}