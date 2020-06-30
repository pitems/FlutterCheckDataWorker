import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class LoginService {
  Future<Response> getInfo(String rut, String date,String date2) async {
    Response response;
    Map<String, dynamic> data = {
      "rut": "${rut.toUpperCase().replaceAll(".", "").replaceAll("-", "")}",
      "initDate": "$date",
      "endDate": "$date2"
    };
    
    try {
      Dio dio = new Dio();
      print(data);
      String url =
          "https://dashboard.frutid.cl/api/mobile/workerData";
      response = await dio.post(url, data:data);
   
    } catch (e) {
      print(e);
    }
    print(response);
    return response;
  }
}
