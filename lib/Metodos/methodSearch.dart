 import 'package:dio/dio.dart';
 
 methodSearch(String element,List keys,Response data1) {
    int index = keys.indexOf(element);
    bool ftn=false;
    bool ftw=false;
    bool fbn=false;

   
    for (var j = 0; j < data1.data["enterprises"][keys[index]].length; j++) {
      if (ftn == false) {
        if (data1.data["enterprises"][keys[index]][j]["method"] == "ftn") {
          
            ftn = true;
          
          
        }
      }
      if (ftw == false) {
        if (data1.data['enterprises'][keys[index]][j]["method"] == "ftw") {
     
            ftw = true;
           
         
        }
      }
      if (fbn == false) {
        if (data1.data['enterprises'][keys[index]][j]["method"] == "fbn") {
   
            fbn = true;
      
        
        }
      }
    }
  Map<String, bool> map1 = {
    'ftn': ftn,
    'ftw': ftw,
    'fbn': fbn
  };
  return map1;
  
  }