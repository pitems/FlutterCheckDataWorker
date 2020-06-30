import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
 
 class Ftnpagos extends StatefulWidget {
   @override
   final String amountftn;
   
  

   Ftnpagos(this.amountftn);
   _FtnpagosState createState() => _FtnpagosState();
 }
 
 class _FtnpagosState extends State<Ftnpagos> {
     TextEditingController amountText = TextEditingController();
   @override
   Widget build(BuildContext context) {
   return Expanded(
      child: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 50,),
            Text(
              "Ingrese el Monto",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: ScreenUtil().setSp(60, allowFontScalingSelf: true)),
            ),
            SizedBox(height: 10,),
            Card(margin :EdgeInsets.all(10),
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
                  controller:amountText,
                  onChanged: (val) {
                      setState(() {
                        
                      });
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
                                "${widget.amountftn}",
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
  
    if (amountText.text != '') {
      total = int.parse(widget.amountftn);
      int totaltext = int.parse(amountText.text);
      total = total * totaltext;
    } else {
      total = 0;
    }
   
 
   var f = new NumberFormat.currency(symbol:"\$",decimalDigits: 0 );
   f.format(total);
    return f.format(total);
  }
 }
 

