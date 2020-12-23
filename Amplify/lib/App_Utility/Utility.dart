import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utility{
  static Utility _shareInstance;
  factory Utility()=>_shareInstance??Utility._();
  Utility._();

  TextStyle returnTextStyle(Color colors,double fontSize){
    return TextStyle(
          fontStyle: FontStyle.normal,
          color:  colors,
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
          fontFamily: 'Poppins-Regular'
    ); 
  }

TextStyle returnLabelStyle(){
  return TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.bold,
        fontSize: 14.0
  ); 
}

  OutlineInputBorder returnBorderWithColor(Color color){
    return OutlineInputBorder(
      borderSide : BorderSide(color:color,
                              width: 1.0),
      borderRadius: BorderRadius.circular(10.0),
    );
  }

  Color hexToColor(String code) {
   return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

}