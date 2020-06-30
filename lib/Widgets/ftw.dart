import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FtwWidget extends StatefulWidget {
  @override
  final String valueftn;
  final String binValueftn;
  final String weight;

  FtwWidget(this.valueftn, this.binValueftn, this.weight);
  _FtwWidgetState createState() => _FtwWidgetState();
}

class _FtwWidgetState extends State<FtwWidget> {
  String value;
  String binValue;
  String weight;
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      binValue = widget.binValueftn;
      value = widget.valueftn;
      weight = widget.weight;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      //Main Container Expanded
      child: Container(
      //  color: Colors.lightGreen[400], //Main Container
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            Row(
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
                          style:  TextStyle(fontSize: ScreenUtil().setSp(100, allowFontScalingSelf: true)),
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
                          "Bins 2",
                          style:  TextStyle(fontSize: ScreenUtil().setSp(100, allowFontScalingSelf: true)),
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
            SizedBox(height: MediaQuery.of(context).size.height*0.1,),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,0,0,25),
              child: Center(child: Text("Peso Total",style:  TextStyle(fontSize: ScreenUtil().setSp(100, allowFontScalingSelf: true)),),),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                    "$weight KG",
                    style:  TextStyle(fontSize: ScreenUtil().setSp(120, allowFontScalingSelf: true)),
                  ),
               
              ],
            )
          ],
        ),
      ),
    );
  }
}
