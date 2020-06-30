import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frutid_workers/Metodos/Hex.dart';
import 'package:frutid_workers/Metodos/methodSearch.dart';
import 'package:frutid_workers/Widgets/fbnpagos.dart';
import 'package:frutid_workers/Widgets/ftn.dart';
import 'package:frutid_workers/Widgets/ftwpagos.dart';
import 'package:intl/intl.dart';
import 'package:frutid_workers/Widgets/ftnpagos.dart';

class Pagos extends StatefulWidget {
  @override
  final Map<String, String> mapData;

  final Map<String, bool> mapDatabool;

  Pagos(this.mapDatabool, this.mapData);
  _PagosState createState() => _PagosState();
}

class _PagosState extends State<Pagos> {
  //Text Controller
  TextEditingController amountText = TextEditingController();
  Map<String, String> mapData;
  Map<String, bool> mapDatabool;
  String date;
  Response data1;
  String element;
  //Colors
  Color activated = Colors.lightGreen[300];
  Color deactivated = Colors.lightGreen[700];
  //bool
  bool ftn = false;
  bool ftnVisible = false;
  bool ftw = false;
  bool ftwVisible = false;
  bool fbn = false;
  bool fbnVisible = false;
  @override
  void initState() {
    //Recover all data from Map
    mapData = widget.mapData;
    mapDatabool = widget.mapDatabool;
    print(mapData);
    //recover Bool
    ftn = mapDatabool['ftn'];
    ftw = mapDatabool['ftw'];
    fbn = mapDatabool['fbn'];
    // TODO: implement initState
    date = mapData['date'];
    if (mapDatabool['ftn'] == true) {
      ftnVisible = true;
    } else if (mapDatabool['ftw'] == true) {
      ftwVisible = true;
    } else if (mapDatabool['fbn'] == true) {
      fbnVisible = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
            gradient:
                LinearGradient(colors: [HexColor("8BC34A"), HexColor("9CCC65")])
            /* image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.2), BlendMode.dstATop),
                image: AssetImage('assets/logoimage.png'))*/

            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.035,
            ),
            SizedBox(
                height: 60,
                child: Card(
                  color: deactivated,
                  child: ListTile(
                      leading: InkWell(
                        onTap:()=> Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        "$date",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenUtil()
                                .setSp(60, allowFontScalingSelf: true)),
                      )),
                )),
            methodSelectionBar(element),
            ftnVisible == true
                ? //ftncalculator()
                Ftnpagos(mapData['valueftn'])
                : ftwVisible == true
                    ? Ftwpagos(mapData['valueftw'], mapData['weightftw'])
                    : fbnVisible == true
                        ? Fbnpagos(mapData['binExportacion'],
                            mapData['binComercial'], mapData['binJugo'])
                        : Text("NO Hay Datos"),
          ],
        ),
      ),
    );
  }

  methodSelectionBar(String element) {
    return Container(
      //color: deactivated,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ftn == true
              ? FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  color: ftnVisible == true ? activated : deactivated,
                  child: Text(
                    "Caja sin Peso",
                    style: TextStyle(
                        fontSize:
                            ScreenUtil().setSp(40, allowFontScalingSelf: true),
                        color:
                            ftnVisible == true ? Colors.black : Colors.white),
                  ),
                  onPressed: () {
                    setState(() {
                      ftnVisible = true;
                      ftwVisible = false;
                      fbnVisible = false;
                      // _ftnCounter(element);
                    });
                  })
              : SizedBox(
                  height: 1,
                ),
          ftw == true
              ? FlatButton(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  color: ftwVisible == true ? activated : deactivated,
                  child: Text("Caja con Peso",
                      style: TextStyle(
                          fontSize: ScreenUtil()
                              .setSp(40, allowFontScalingSelf: true),
                          color: ftwVisible == true
                              ? Colors.black
                              : Colors.white)),
                  onPressed: () {
                    setState(() {
                      ftnVisible = false;
                      ftwVisible = true;
                      fbnVisible = false;
                      //_ftwCounter(element);
                    });
                  })
              : SizedBox(
                  height: 1,
                ),
          fbn == true
              ? FlatButton(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  color: fbnVisible == true ? activated : deactivated,
                  child: Text("      Bins      ",
                      style: TextStyle(
                          fontSize: ScreenUtil()
                              .setSp(40, allowFontScalingSelf: true),
                          color: fbnVisible == true
                              ? Colors.black
                              : Colors.white)),
                  onPressed: () {
                    setState(() {
                      ftnVisible = false;
                      ftwVisible = false;
                      fbnVisible = true;
                      // _countBoxesfbn(element);
                    });
                  })
              : SizedBox(
                  height: 1,
                )
        ],
      ),
    );
  }

  ftncalculator() {
    return Expanded(
      child: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Text(
              "Ingrese el Monto",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: ScreenUtil().setSp(60, allowFontScalingSelf: true)),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              margin: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Ingrese Cantidad",
                    hintText: "Ingrese un Numero",
                    //fillColor: Colors.white,
                  ),
                  keyboardType: TextInputType.number,
                  controller: amountText,
                  onChanged: (val) {
                    setState(() {});
                  },
                  maxLength: 5,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize:
                          ScreenUtil().setSp(45, allowFontScalingSelf: true)),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
                          child: Column(
                            children: <Widget>[
                              Icon(
                                Icons.featured_video,
                                size: 50,
                              ),
                              Text(
                                "Cajas",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: ScreenUtil()
                                        .setSp(60, allowFontScalingSelf: true)),
                              ),
                              Text(
                                "${mapData['valueftn']}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: ScreenUtil()
                                        .setSp(60, allowFontScalingSelf: true)),
                              )
                            ],
                          ),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
                          child: Column(
                            children: <Widget>[
                              Icon(
                                Icons.attach_money,
                                size: 50,
                              ),
                              Text(
                                "Total",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: ScreenUtil()
                                        .setSp(60, allowFontScalingSelf: true)),
                              ),
                              Text(
                                "${calculateftn()}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: ScreenUtil()
                                        .setSp(60, allowFontScalingSelf: true)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  calculateftn() {
    int total;
    MaskedTextController mask = MaskedTextController(mask: "00.000.000");
    if (amountText.text != '') {
      total = int.parse(mapData['valueftn']);
      int totaltext = int.parse(amountText.text);
      total = total * totaltext;
    } else {
      total = 0;
    }
    setState(() {
      mask.text = total.toString();
    });

    var f = new NumberFormat.currency(symbol: "\$", decimalDigits: 0);
    f.format(total);
    return f.format(total);
  }
}
