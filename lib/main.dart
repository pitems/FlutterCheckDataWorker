import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frutid_workers/Pages/infocosechero.dart';
import 'package:frutid_workers/Pages/login.dart';

void main() => runApp(
    MaterialApp(
      title: "Frutid Trabajador",
    initialRoute: '/',
    routes: {
      '/': (context) =>login(),
     // 'info':(context)=>InfoCosecheros()
      
    },
  ),
);


