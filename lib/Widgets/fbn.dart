import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FbnWidget extends StatefulWidget {
  @override
  final String valueftn;
  final String binValueComercial;
  final String binValueExportacion;
  final String binValueJugo;
  FbnWidget(this.valueftn, this.binValueComercial,this.binValueExportacion,this.binValueJugo);
  _FbnWidgetState createState() => _FbnWidgetState();
}

class _FbnWidgetState extends State<FbnWidget> {
  String value;
  String binComercial;
  String binExportacion;
  String binJugo;
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      binComercial = widget.binValueComercial;
      value = widget.valueftn;
      binExportacion = widget.binValueExportacion;
      binJugo=widget.binValueJugo;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int smallText=40;
  int bigtext = 80;
    return Expanded(
      //Main Container Expanded
      child: Container(
        // color: Colors.lightGreen[400], //Main Container
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              //Container Column 2
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                    child: AutoSizeText(
                      "Bins Comercial",
                      minFontSize: 18,
                      maxFontSize: 50,
                      style: TextStyle(
                          fontSize: ScreenUtil()
                              .setSp(smallText, allowFontScalingSelf: true)),
                    ),
                  ),
                  Text(
                    "$binComercial",textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: ScreenUtil()
                            .setSp(bigtext, allowFontScalingSelf: true)),
                  ),
                  
                ],
              ),
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                    child: AutoSizeText(
                      "Bins Exportacion",
                      minFontSize: 18,
                      maxFontSize: 50,
                      style: TextStyle(
                          fontSize: ScreenUtil()
                              .setSp(smallText, allowFontScalingSelf: true)),
                    ),
                  ),
                  Text(
                    "$binExportacion",textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: ScreenUtil()
                            .setSp(bigtext, allowFontScalingSelf: true)),
                  ),
                  
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                    child: AutoSizeText(
                      "Bins Jugo",
                      minFontSize: 18,
                      maxFontSize: 50,
                      style: TextStyle(
                          fontSize: ScreenUtil()
                              .setSp(smallText, allowFontScalingSelf: true)),
                    ),
                  ),
                  Text(
                    "$binJugo",textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: ScreenUtil()
                            .setSp(bigtext, allowFontScalingSelf: true)),
                  ),
                  
                ],
              ),
          ],
        ),
      ),
    );
  }
}
