import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FtnWidget extends StatefulWidget {
  @override
  final String valueftn;
  final String binValueftn;

  FtnWidget(this.valueftn,this.binValueftn);
  _FtnWidgetState createState() => _FtnWidgetState();
}

class _FtnWidgetState extends State<FtnWidget> {
  String value;
  String binValue;
 
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      binValue=widget.binValueftn;
      value=widget.valueftn;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Expanded(
              //Main Container Expanded
              child: Container(
               // color: Colors.lightGreen[400], //Main Container
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                       //Container Column 1
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                            child: Text(
                              "Cajas",
                              style: TextStyle(
                                fontSize:ScreenUtil().setSp(100, allowFontScalingSelf: true),
                              ),
                            ),
                          ),
                          Text(
                            "$value",
                            
                            style: TextStyle(fontSize: ScreenUtil().setSp(120, allowFontScalingSelf: true)),
                          ),
                        ],
                      ),
                    ),
                   /* Container(
                  //Container Column 2
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                            child: Text(
                              "Bins",
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(100, allowFontScalingSelf: true),
                              ),
                            ),
                          ),
                          Text(
                            "$binValue",
                            style:  TextStyle(fontSize: ScreenUtil().setSp(120, allowFontScalingSelf: true)),
                          ),
                        ],
                      ),
                    )*/
                  ],
                ),
              ),
            );
  }
}
