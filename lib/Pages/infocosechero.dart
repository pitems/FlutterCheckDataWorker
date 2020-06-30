import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frutid_workers/Metodos/Hex.dart';
import 'package:frutid_workers/Pages/Pagos.dart';
import 'package:frutid_workers/Pages/login.dart';
import 'package:frutid_workers/Services/LoginService.dart';
import 'package:frutid_workers/Widgets/fbn.dart';
import 'package:frutid_workers/Widgets/ftn.dart';
import 'package:frutid_workers/Widgets/ftw.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:intl/intl.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:frutid_workers/Metodos/ftnCounter.dart';
import 'package:frutid_workers/Metodos/ftwCounter.dart';
import 'package:frutid_workers/Metodos/fbnCounter.dart';
import 'package:frutid_workers/Metodos/methodSearch.dart';

class InfoCosecheros extends StatefulWidget {
  final Response response;
  final String rut;
  final String date;

  InfoCosecheros(this.response, this.rut, this.date);
  @override
  _InfoCosecherosState createState() => _InfoCosecherosState();
}

class _InfoCosecherosState extends State<InfoCosecheros> {
  List keys = [];
  List<String> dropData = [];
  String _selectedData;
  String value;
  String binValueComercial;
  String binValueExportacion;
  String binValueJugo;
  String weight;
  //Booleans
  bool ftn = false;
  bool ftw = false;
  bool fbn = false;
  //Bools visibility
  bool ftnVisible = false;
  bool ftwVisible = false;
  bool fbnVisible = false;
  //bool actualizacion
  bool cambio = false;
  //Counter general de tipos de trabajo

  //List Methods
  List methodsList = [];
  //fechas
  var fechaInicial;
  var inicioMostrar = "";
  var fechafinal;
  var finalMostrar = "";
  //Response
  Response data1;
  //Data exist
  bool dataexist = false;
  //First time bool
  bool firsttime = false;
  //Actualizando
  bool actualizando = false;
  bool actualizarcambio = false;
  //Colors
  Color activated = Colors.lightGreen[300];
  Color deactivated = Colors.lightGreen[700];
  //New Method
  List empresa = [];
  //User Data
  String name;
  //Map Data
  Map<String, String> pagosdata;
  Map<String, bool> pagosdatabool;
  @override
  void initState() {
    checkData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return WillPopScope(
      onWillPop: logout,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[800],
          title: Container(
            color: Colors.green[50],
            child: dataexist == true
                ? DropdownButton(
                    //DropDownMenu
                    icon: Icon(Icons.pin_drop),
                    isExpanded: true,

                    value: _selectedData,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedData = newValue;
                      });
                      actualizarcambio = true;
                      clearMethods();
                      activateMethod(_selectedData);
                      methodVisibility(_selectedData);
                      //  print(_selectedData);
                    },
                    items: keys.map((location) {
                      return DropdownMenuItem(
                        child: new Text(location),
                        value: location,
                      );
                    }).toList(),
                  )
                : Text(""),
          ),
        ),
        drawer: drawer(),
        /* 
         Drawer(
          child: Container(
            color: Colors.lightGreen[400],
            child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                    accountName: Text(name),
                    currentAccountPicture: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage("assets/user.png"),
                    ),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/greenheadbar.jpeg")))),
                SizedBox(
                  height: 50,
                  child: FlatButton(
                    color: Colors.green[200],
                    child: Text("Selección Fecha"),
                    onPressed: () {
                      showPickerDateRange(context);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: SizedBox(
                    height: 50,
                    child: FlatButton(
                      color: Colors.green[200],
                      child: Text("Calcular Pago"),
                      onPressed: () {
                        _recoverDataMap(_selectedData);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Pagos(pagosdatabool, pagosdata)));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        */
        body: DecoratedBox(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.2), BlendMode.dstATop),
                  image: AssetImage('assets/logoimage.png'))),
          child: actualizando == true || actualizarcambio == true
              ? loadingdata()
              : dataexist == false
                  ? nodata()
                  : Container(
                      //  color: Colors.blueGrey, //Contenedor Principal
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            color: deactivated,
                            child: Center(
                                child: Text(
                              inicioMostrar + " - " + finalMostrar,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: ScreenUtil()
                                      .setSp(60, allowFontScalingSelf: true)),
                            )),
                          ),
                          methodSelectionBar(_selectedData),

                          //Clase
                          _showWidgets(),
                        ],
                      ),
                    ),
        ),
      ),
    );
  }

  loadingdata() {
    return Center(
        child: LoadingBouncingGrid.square(
      backgroundColor: deactivated,
      inverted: true,
      size: MediaQuery.of(context).size.height * 0.2,
    ));
  }

  _showWidgets() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        actualizarcambio = false;
      });
    });

    return ftnVisible == true
        ? FtnWidget(value, binValueComercial)
        : ftwVisible == true
            ? FtwWidget(value, binValueComercial, weight)
            : FbnWidget(
                value, binValueComercial, binValueExportacion, binValueJugo);
  }

  //Metod Count Boxes
  _ftnCounter(String element) {
    Map<String, String> map1 = countBoxesftn(element, keys, data1);
    setState(() {
      value = map1['value'];
      binValueComercial = map1['binValueComercial'];
    });
  }

  _ftwCounter(String element) {
    Map<String, String> map1 = countBoxesftw(element, keys, data1);

    //    print(value + "Cajas" + binValue + "Bin Value");
    setState(() {
      value = map1['value'];
      binValueComercial = map1['binValueComercial'];
      weight = map1['weight'];
    });
  }

  _countBoxesfbn(String element) {
    Map<String, String> map1 = countBoxesfbn(element, keys, data1);

//    print(value + "Cajas" + binValue + "Bin Value");
    setState(() {
      binValueComercial = map1['binValueComercial'];
      binValueExportacion = map1['binValueExportacion'];
      binValueJugo = map1['binValueJugo'];
      // binValue = "${bins.length}";
    });
  }

  _recoverDataMap(String element) {
    //Strings
    String valueftn;
    String valueftw;
    String weightftw;
    String binComercial;
    String binExportacion;
    String binJugo;
    String date = inicioMostrar + " - " + finalMostrar;
    Map<String, String> ftnMap = countBoxesftn(element, keys, data1);
    valueftn = ftnMap['value'];
    Map<String, String> ftwMap = countBoxesftw(element, keys, data1);
    valueftw = ftwMap['value'];
    weightftw = ftwMap['weight'];
    Map<String, String> map1 = countBoxesfbn(element, keys, data1);
    binComercial = map1['binValueComercial'];
    binExportacion = map1['binValueExportacion'];
    binJugo = map1['binValueJugo'];

    pagosdata = {
      'date': date,
      'valueftn': valueftn,
      'valueftw': valueftw,
      'weightftw': weightftw,
      'binComercial': binComercial,
      'binExportacion': binExportacion,
      'binJugo': binJugo
    };
    pagosdatabool = {'ftn': ftn, 'ftw': ftw, 'fbn': fbn};
  }

  clearMethods() {
    setState(() {
      ftn = false;
      ftnVisible = false;
      ftw = false;
      ftwVisible = false;
      fbn = false;
      fbnVisible = false;
    });
  }

  methodVisibility(String element) {
    setState(() {
      if (ftn == true) {
        ftnVisible = true;
        _ftnCounter(element);
      } else if (ftw == true) {
        ftwVisible = true;
        _ftwCounter(element);
      } else if (fbn == true) {
        fbnVisible = true;
        _countBoxesfbn(element);
      }
    });
  }

  activateMethod(String element) {
    Map<String, bool> map1 = methodSearch(element, keys, data1);
    ftn = map1['ftn'];
    ftw = map1['ftw'];
    fbn = map1['fbn'];
  }

  nodata() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "No Hay Datos",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenUtil().setSp(70, allowFontScalingSelf: true)),
            ),
          )
        ],
      ),
    );
  }

  methodSelectionBar(String element) {
    return Container(
      color: deactivated,
      child: Row(
        children: <Widget>[
          ftn == true
              ? Expanded(
                  flex: 1,
                  child: FlatButton(
                      color: ftnVisible == true ? activated : deactivated,
                      child: Text(
                        "Caja sin Peso",
                        style: TextStyle(
                            color: ftnVisible == true
                                ? Colors.black
                                : Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          ftnVisible = true;
                          ftwVisible = false;
                          fbnVisible = false;
                          _ftnCounter(element);
                        });
                      }),
                )
              : SizedBox(
                  height: 1,
                ),
          ftw == true
              ? Expanded(
                  flex: 1,
                  child: FlatButton(
                      color: ftwVisible == true ? activated : deactivated,
                      child: Text("Caja con Peso",
                          style: TextStyle(
                              color: ftwVisible == true
                                  ? Colors.black
                                  : Colors.white)),
                      onPressed: () {
                        setState(() {
                          ftnVisible = false;
                          ftwVisible = true;
                          fbnVisible = false;
                          _ftwCounter(element);
                        });
                      }),
                )
              : SizedBox(
                  height: 1,
                ),
          fbn == true
              ? Expanded(
                  flex: 1,
                  child: FlatButton(
                      color: fbnVisible == true ? activated : deactivated,
                      child: Text("Bins",
                          style: TextStyle(
                              color: fbnVisible == true
                                  ? Colors.black
                                  : Colors.white)),
                      onPressed: () {
                        setState(() {
                          ftnVisible = false;
                          ftwVisible = false;
                          fbnVisible = true;
                          _countBoxesfbn(element);
                        });
                      }),
                )
              : SizedBox(
                  height: 1,
                )
        ],
      ),
    );
  }

  showPickerDateRange(BuildContext context) {
    var inicio;
    var fechaF;
    //  print("canceltext: ${PickerLocalizations.of(context).cancelText}");

    Picker ps = new Picker(
        hideHeader: true,
        adapter: new DateTimePickerAdapter(
            type: PickerDateTimeType.kYMD, isNumberMonth: false),
        onConfirm: (Picker picker, List value) {
          inicio = (picker.adapter as DateTimePickerAdapter).value;
          fechaInicial = DateFormat("yyyy-MM-ddT00:00:00").format(inicio);
          inicioMostrar = DateFormat("dd/MM/yyyy").format(inicio);
        });

    Picker pe = new Picker(
        hideHeader: true,
        adapter: new DateTimePickerAdapter(type: PickerDateTimeType.kYMD),
        onConfirm: (Picker picker, List value) {
          fechaF = (picker.adapter as DateTimePickerAdapter).value;
          fechafinal = DateFormat("yyyy-MM-ddT23:59:59").format(fechaF);
          finalMostrar = DateFormat("dd/MM/yyyy").format(fechaF);
        });

    List<Widget> actions = [
      FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: new Text("Cancelar")),
      FlatButton(
          onPressed: () async {
            setState(() {
              actualizando = true;
            });
            var responseOK;
            Navigator.pop(context);
            Navigator.pop(context);
            ps.onConfirm(ps, ps.selecteds);
            pe.onConfirm(pe, pe.selecteds);

            responseOK = await LoginService()
                .getInfo(widget.rut, fechaInicial, fechafinal);
            setState(() {
              keys.clear();
              data1 = responseOK;
              actualizando = false;
              clearMethods();
              checkData();
            });
          },
          child: new Text(PickerLocalizations.of(context).confirmText + "ar"))
    ];

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text("Seleccione rango de fecha"),
            actions: actions,
            content: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Inicio:"),
                  ps.makePicker(),
                  Text("Fin:"),
                  pe.makePicker()
                ],
              ),
            ),
          );
        });
  }

  checkData() {
    if (firsttime == false) {
      data1 = widget.response;
      recoverdata();
      inicioMostrar = widget.date;
      finalMostrar = widget.date;

      firsttime = true;
    }
    if (data1.data["enterprises"].toString() != "{}") {
      setState(() {
        dataexist = true;
      });

      for (var i in data1.data["enterprises"].keys) {
        keys.add(i);
        dropData.add(i);
      }

      setState(() {
        _selectedData = keys.first;
        activateMethod(keys.first);
        methodVisibility(keys.first);
      });
    } else {
      clearMethods();
      setState(() {
        dataexist = false;
      });
    }
  }

  recoverdata() {
    name = data1.data["workerData"]["name"] +
        " " +
        data1.data["workerData"]["lastname"];
  }

  Future<bool> logout() {
    return logoutalert();
  }

  logoutalert() {
    Alert(
        style: AlertStyle(
            isCloseButton: false,
            animationType: AnimationType.grow,
            animationDuration: Duration(milliseconds: 500)),
        context: context,
        type: AlertType.info,
        title: "¿Desea Cerrar Sesión?",
        desc: "Cerrara la sesión actual",
        buttons: [
          DialogButton(
            color: Colors.red,
            child: Text(
              "Cerrar Sesión",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => login()));
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

  drawer() {
    return ClipPath(
        clipper: OvalRightBorderClipper(),
        child: Container(
            padding: const EdgeInsets.only(left: 0.0, right: 10),
            decoration: BoxDecoration(
                color: Colors.lightGreen[400],
                boxShadow: [BoxShadow(color: Colors.black45)]),
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height,
            child: SafeArea(
                child: SingleChildScrollView(
                    child: Column(children: <Widget>[
              GestureDetector(
                  child: Hero(
                      tag: 'Hero',
                      child: UserAccountsDrawerHeader(
                        accountName: Text(name),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage("assets/greenheadbar.jpg"),
                            )),
                      ))),
              Container(
                color: Colors.green[200],
                child: ListTile(
                  title: Text("Seleccion Fecha"),
                  trailing: Image.asset(
                    'assets/calendar.png',
                    width: 60,
                  ),
                  onTap: () {
                    showPickerDateRange(context);
                  },
                ),
              ),
              SizedBox(height: 20,),
              Container(
                color: Colors.green[200],
                child: ListTile(
                  title: Text("Calcular Pagos"),
                  trailing: Image.asset(
                    'assets/money.png',
                    width: 60,
                  ),
                  onTap: () {
                   _recoverDataMap(_selectedData);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Pagos(pagosdatabool, pagosdata)));
                  },
                ),
              ),
            ])))));
  }
} //Le end
