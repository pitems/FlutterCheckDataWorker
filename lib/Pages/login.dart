import 'dart:ui';

import 'package:dart_rut_validator/dart_rut_validator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frutid_workers/Pages/infocosechero.dart';
import 'package:frutid_workers/Services/LoginService.dart';
import 'package:intl/intl.dart';
import 'package:frutid_workers/Metodos/Hex.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  //Data
  String snacktext;
  TextEditingController _rutController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Color deactivated = Colors.lightGreen[700];
  @override
  void initState() {
    // TODO: implement initState
    _rutController.clear();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: quit,
      child: Scaffold(
        key: _scaffoldKey,
        //backgroundColor: HexColor('DAEFB3'),
        body: DecoratedBox(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.2), BlendMode.dstATop),
                  image: AssetImage('assets/logoimage.png'))),
          child: SingleChildScrollView(scrollDirection: Axis.vertical,
                      child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height*0.21,),
                Center(
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage("assets/user.png"),
                  ),
                ),
                SizedBox(
                  height: 120,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      //autovalidate: true,
                      textAlign: TextAlign.center,
                      controller: _rutController,
                      onChanged: onChangedApplyFormat,
                      validator:
                          RUTValidator(validationErrorText: 'Ingrese RUT válido')
                              .validator,
                      decoration: InputDecoration(
                          labelText: "Ingrese su rut",
                          fillColor: Colors.white,
                          filled: true),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                    child: Text(
                      "Ingresar",
                      style: TextStyle(fontSize: 30),
                    ),
                    color: Colors.blueGrey[50],
                    onPressed: () async {
                      print(DateFormat("yyyy-MM-ddT").format(DateTime.now()));

                      if (_formKey.currentState.validate()) {
                        _displaySnackBar(context);
                        var fecha =
                            DateFormat("dd/MM/yyyy").format(DateTime.now());
                        var fechaserver = DateFormat("yyyy-MM-ddT00:00:00")
                            .format(DateTime.now());
                        var fechaserver2 = DateFormat("yyyy-MM-ddT23:59:59")
                            .format(DateTime.now());
                        /*  var data = await LoginService().getInfo(_rutController.text,
                            fecha,fecha);*/

                        var data = await LoginService().getInfo(
                            _rutController.text, fechaserver, fechaserver2);
                        if (data == null) {
                          errorAlert();
                        } else {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InfoCosecheros(
                                      data, _rutController.text, fecha)));
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//Methods
  void onChangedApplyFormat(String text) {
    RUTValidator.formatFromTextController(_rutController);
  }

  _displaySnackBar(BuildContext context) {
    _scaffoldKey.currentState.showSnackBar(snack);
  }

  final SnackBar snack = SnackBar(
      elevation: 1,
      duration: Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {},
      ),
      content: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0)
            .add(EdgeInsets.only(left: 10.0)),
        //margin: EdgeInsets.only(bottom: 8.0),
        child: Text(
          'Conectando al Servidor',
          style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 16,
              wordSpacing: 0.7,
              fontStyle: FontStyle.italic),
        ),
      ));

  Future<void> getInfo() async {
    Map<String, dynamic> data = {
      "rut": "186820223",
      "initDate": "2019-01-01T00:00:00",
      "endDate": "2019-12-31T23:59:59"
    };
    try {
      Dio dio = new Dio();
      Response response;
      String url =
          "https://kh3usfvkk9.execute-api.us-east-1.amazonaws.com/dev/workerData";
      response = await dio.post(url, data: data);
      print(response.data);
    } catch (e) {
      print(e);
    }
  }

  Future<bool> quit() {
    return quitAlert();
  }

  quitAlert() {
    Alert(
        style: AlertStyle(
            isCloseButton: false,
            animationType: AnimationType.grow,
            animationDuration: Duration(milliseconds: 500)),
        context: context,
        type: AlertType.info,
        title: "¿Desea Cerrar la Aplicación?",
        desc: "Cerrará la aplicación",
        buttons: [
          DialogButton(
            color: Colors.red,
            child: Text(
              "Cerrar",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              SystemNavigator.pop();
            },
          ),
          DialogButton(
            color: deactivated,
            child: Text(
              "Cancelar",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ]).show();
  }

  errorAlert() {
    Alert(
        style: AlertStyle(
            isCloseButton: false,
            animationType: AnimationType.grow,
            animationDuration: Duration(milliseconds: 500)),
        context: context,
        type: AlertType.warning,
        title: "Error Conexion",
        
        buttons: [
         
          DialogButton(
            color: deactivated,
            child: Text(
              "Cerrar",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ]).show();
  }
}
