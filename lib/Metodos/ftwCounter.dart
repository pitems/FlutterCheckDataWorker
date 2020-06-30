import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

countBoxesftw(String element, List keys, Response data1) {
  int index = keys.indexOf(element);
  List<String> bins = [];
  int total = 0;
  double weighttotal = 0.0;
  for (var j = 0; j < data1.data["enterprises"][keys[index]].length; j++) {
    if (data1.data["enterprises"][keys[index]][j]["method"] == "ftw") {
      weighttotal = weighttotal +
          double.parse(
              data1.data["enterprises"][keys[index]][j]['scans'][0]["weight"]);
      total = total +
          data1.data["enterprises"][keys[index]][j]['scans'][0]["boxes"].length;
      if (bins.contains(data1.data["enterprises"][keys[index]][j]["bin"])) {
        //Si el bin existe en la lista de bins
      } else {
        bins.add(data1.data["enterprises"][keys[index]][j]["bin"]);
      }
    }
  }

  //    print(value + "Cajas" + binValue + "Bin Value");
  Map<String, String> map1 = {
    'value': "${total.toString()}",
    'binValueComercial': "${bins.length}",
    'weight': "${weighttotal.toStringAsFixed(2)}"
  };
  return map1;
}
