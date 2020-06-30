import 'package:flutter/material.dart';
import 'package:dio/dio.dart';


  countBoxesfbn(String element,List keys,Response data1) {
    int index = keys.indexOf(element);
    List<String> bins = [];
    double totalComercial = 0.0;
    double totalExportacion = 0.0;
    double totalJugo = 0.0;
    for (var j = 0; j < data1.data["enterprises"][keys[index]].length; j++) {
      if (data1.data["enterprises"][keys[index]][j]["method"] == "fbn") {
 
          if (data1.data["enterprises"][keys[index]][j]["binType"] ==
              "comercial") {
       
            totalComercial = totalComercial +
                _addBins((data1.data["enterprises"][keys[index]][j]
                        ['workerCollected']
                    .toString()));
          }

          if (data1.data["enterprises"][keys[index]][j]["binType"] ==
              "exportacion") {
            totalExportacion = totalExportacion +
                _addBins((data1.data["enterprises"][keys[index]][j]
                        ['workerCollected']
                    .toString()));
          }

          if (data1.data["enterprises"][keys[index]][j]["binType"] == "jugo") {
            totalJugo = totalJugo +
                _addBins((data1.data["enterprises"][keys[index]][j]
                        ['workerCollected']
                    .toString()));
          }
     
      }
    }

//    print(value + "Cajas" + binValue + "Bin Value");
   Map<String, String> map1 = {
    'binValueComercial': "${totalComercial.toStringAsFixed(2)}",
    'binValueExportacion': "${totalExportacion.toStringAsFixed(2)}",
    'binValueJugo':  "${totalJugo.toStringAsFixed(2)}"
  };
     return map1;
  }

    _addBins(String s) {
    return double.tryParse(s);
  }