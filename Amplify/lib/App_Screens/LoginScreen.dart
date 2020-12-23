
import 'dart:async';
import 'package:Amplify/App_Utility/AppRouter.dart';
import 'package:Amplify/App_Utility/Constant.dart';
import 'package:Amplify/App_Utility/FormValidator.dart';
import 'package:Amplify/App_Utility/Utility.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget{
  List<FieldMap> _fieldNames = _returnFiledNames();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context){
      return Scaffold(
       body:  Form(
         key: _formKey,
         child: Center(
            child: Container(
              color:Colors.black,
              child:_returnSubState(context)
            )
        ),
       )
      );
  }

  //MARK:- Sub state
  Container _returnSubState(BuildContext context){
      return Container(
        padding: EdgeInsets.only(top:100),
        child: new ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: _fieldNames.length,
          itemBuilder: (BuildContext cntx,int index){
            final _fieldMap = _fieldNames[index];
            return Container(
              child:_returnContainerWithIndex(index,_fieldMap,context),
            );
          }),
      );
  }

  Container _returnContainerWithIndex(int index,FieldMap _fieldMap,BuildContext context){
      double _fieldHeight = returnHeightForContainerWithIndex(index, _fieldMap);
        return Container(
            height: _fieldHeight,
            child: Container(
              child: _returnChildWithIndex(index,_fieldMap,context),
            ),
        );
  }

  Container _returnChildWithIndex(int index,FieldMap _fieldMap, BuildContext context){
     switch (_fieldMap.fieldType) {
        case kImag:
          return Container(
            child: Image.asset(
               ('assets/images/logo.png'),
               color: Utility().hexToColor(kBackgroundColor),
            ),
          );
          break;
        case kTextField:
           return Container(
             height: 60.0,
             padding: EdgeInsets.fromLTRB(20.0, 4.0, 20.0, 4.0),
             child: TextFormField(
              obscureText:(index == 4) ? true : false,
              style: Utility().returnTextStyle(Colors.white,14.0),
              decoration: InputDecoration(
              labelText:_fieldMap.fieldName,
              labelStyle: Utility().returnLabelStyle(),
              enabledBorder: Utility().returnBorderWithColor(Colors.white),
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              border: Utility().returnBorderWithColor(Colors.white),
              errorStyle: TextStyle(
                        fontSize:14.0,
                        color: Colors.red
                    )
             ),
             onChanged: (value){
               
             },
             validator: (value){
               return FormValidator().formValidationWithIndex(index, value,0);
             },
            ),
          );
          break;
        case kButton:
          return Container(
            padding: (index == 6) ? EdgeInsets.only(left:210) : EdgeInsets.fromLTRB(20.0, 4.0, 20.0, 4.0),
            child: FlatButton.icon(
            onPressed: (){
               navigateToPageWithIndex(index,context);
            }, 
            icon:  (index == 10 || index == 12) ? Image.asset('assets/images/${(index == 10) ? "facebook.png" : "google.png"}'): Container(),
            label:Text(_fieldMap.fieldName,
                        style: Utility().returnTextStyle(((index == 8) ? Colors.black : Colors.white),14.0)),
            color: (index == 8) ? Utility().hexToColor(kBackgroundColor) : Colors.transparent,
            textColor: Colors.white,
            shape: StadiumBorder(),
            ),
          );   
          break;
          case kLine:
            return Container(
             padding: EdgeInsets.fromLTRB(20.0, 4.0, 20.0, 4.0),
             child: Container(color: Colors.white)
          );  
      }
      return Container();
  }

 void navigateToPageWithIndex(int index,BuildContext context){
  switch (index) {
    case 8:
         if (_formKey.currentState.validate()) {
            setShowDialog(context);
         }      
      break;
    case 16:
         Navigator.pushNamed(context, signUpRoute);
         break;
    default:
  }
}
  double returnHeightForContainerWithIndex(int index,FieldMap _fieldMap){
    switch (_fieldMap.fieldType) {
        case kImag:
          return 60.0;
        case kTextField:
          return 74.0;
        case kButton:
          return (index == 8) ? 60.0 : 30.0;
        case kLine:
          return 9.0;
      }
      return (index == 3 || index == 7) ? 10.0 :   30.0;
  }
}


//MARK:- Field Type and Field Name
List<FieldMap> _returnFiledNames(){
   List<FieldMap> fieldMap = List();
   fieldMap.add(FieldMap(kImag,"Logo"));
   fieldMap.add(FieldMap(kContainer,""));
   fieldMap.add(FieldMap(kTextField,"Username or Email address"));
   fieldMap.add(FieldMap(kContainer,""));
   fieldMap.add(FieldMap(kTextField,"Password"));
   fieldMap.add(FieldMap(kContainer,""));
   fieldMap.add(FieldMap(kButton,"Forgotten password?"));
   fieldMap.add(FieldMap(kContainer,""));
   fieldMap.add(FieldMap(kButton,"LOG IN"));
   fieldMap.add(FieldMap(kContainer,""));
   fieldMap.add(FieldMap(kButton,"Continue with FaceBook"));
   fieldMap.add(FieldMap(kContainer,""));
   fieldMap.add(FieldMap(kButton,"Continue with Google"));
   fieldMap.add(FieldMap(kContainer,""));
   fieldMap.add(FieldMap(kLine,""));
   fieldMap.add(FieldMap(kContainer,""));
   fieldMap.add(FieldMap(kButton,"Don't have an account? Signup"));
   return fieldMap;
}

//MARK:- Field Map class
class FieldMap{
  String fieldType;
  String fieldName;
  FieldMap(
    this.fieldType,
    this.fieldName
  );
}

setShowDialog(BuildContext context){
  Timer _timer;
  int _start = 0;
   showDialog(
    context: context,
    builder: (BuildContext ctxt){
      return AlertDialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 160),
        content: StatefulBuilder(
          builder: (BuildContext altCntx,StateSetter setState){
            _timer = Timer(Duration(seconds: 1), () {
              _start =_start  + 1;
              if(_start == 5){
                 Navigator.pop(context);
                 Navigator.pushNamed(context, homeRoute);
                  _timer.cancel();
              }else{
                  setState(() { });
              }
            });
            return Container( 
                height: 60.0,
                child: Text(_start.toString(),
                textAlign: TextAlign.center,
                style: Utility().returnTextStyle(Colors.black,48.0))
            );
          }
        )
    );
    }
   );
}
