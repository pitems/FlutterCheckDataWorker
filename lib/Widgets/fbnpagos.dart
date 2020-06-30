import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class Fbnpagos extends StatefulWidget {
  @override
  final String exportacion;
  final String comercial;
  final String jugo;
 

  Fbnpagos(this.exportacion,this.comercial,this.jugo);
  _FbnpagosState createState() => _FbnpagosState();
}

class _FbnpagosState extends State<Fbnpagos> {
  TextEditingController amountTextfbn = TextEditingController();
  List calculo = ["Exportación", "Comercial","Jugo"];
  String _selectedData = "Exportación";
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: SingleChildScrollView(scrollDirection: Axis.vertical,
                  child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Text(
                "Seleccione Metodo de Pago",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: ScreenUtil().setSp(50, allowFontScalingSelf: true)),
              ),
              Card(margin: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                            child: DropdownButton(
                  //DropDownMenu
                  icon: Icon(Icons.pin_drop),
                  isExpanded: true,
                  
                  value: _selectedData,
                  onChanged: (newValue) {
                    amountTextfbn.clear();
                    setState(() {
                      _selectedData = newValue;
                    });
                    //  print(_selectedData);
                  },
                  items: calculo.map((location) {
                    return DropdownMenuItem(
                      child: new Text(location),
                      value: location,
                    );
                  }).toList(),
                ),
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
                    controller: amountTextfbn,
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
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
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
                                        "Bins",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: ScreenUtil().setSp(60,
                                                allowFontScalingSelf: true)),
                                      ),
                                _selectedData.contains("Exportación")
                                    ? Text(
                                        "${widget.exportacion}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: ScreenUtil().setSp(60,
                                                allowFontScalingSelf: true)),
                                      )
                                    : _selectedData.contains("Comercial") ? Text(
                                        "${widget.comercial} ",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: ScreenUtil().setSp(60,
                                                allowFontScalingSelf: true)),
                                      ):Text(
                                        "${widget.jugo} ",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: ScreenUtil().setSp(60,
                                                allowFontScalingSelf: true)),
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
              
            ],
          ),
        ),
      ),
    );
  }

  calculateftn() {
   double total;

    if (amountTextfbn.text != '') {
      if (_selectedData.contains("Exportación")) {
        double convertir = double.parse(widget.exportacion);
        total = convertir;
        
      } else if (_selectedData.contains("Comercial")) {
       double convertir = double.parse(widget.comercial);
        total = convertir;
      }else{
        double convertir = double.parse(widget.jugo);
        total = convertir;
      }

      int totaltext = int.parse(amountTextfbn.text);
      total = total * totaltext;
    } else {
      total = 0;
    }

    var f = new NumberFormat.currency(symbol: "\$", decimalDigits: 0);
    f.format(total);
    return f.format(total);
  }
}
