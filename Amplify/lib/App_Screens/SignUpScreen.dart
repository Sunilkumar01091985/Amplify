import 'package:Amplify/App_Utility/AppRouter.dart';
import 'package:Amplify/App_Utility/Constant.dart';
import 'package:Amplify/App_Utility/FormValidator.dart';
import 'package:Amplify/App_Utility/Utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';



class SignUpScreen extends StatelessWidget{
  List<FieldMap> _fieldNames = _returnFiledNames();
  @override
  Widget build(BuildContext context){
     return Scaffold(
       appBar: AppBar(
          title:null,
          backgroundColor: Colors.black,
           elevation: 0,
            leading:IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () => {
                Navigator.of(context).pop()
              },
            )
        ),
       body: Center(
         child: Container(
              color:Colors.black,
              child:_returnSubState(context)
            )
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
            padding: EdgeInsets.fromLTRB(20.0, 4.0, 20.0, 4.0),
            child: FlatButton.icon(
            onPressed: (){
               navigateToPageWithIndex(index,context);
            }, 
            icon: (index == 4 || index == 6) ? Image.asset('assets/images/${(index == 4) ? "facebook.png" : "google.png"}'): Container(),
            label:Text(_fieldMap.fieldName,
                        style: Utility().returnTextStyle(((index == 6) ? Colors.black :  Colors.white),14.0)),
            color: (index == 4) ? Colors.blue : (index == 6) ? Colors.white : Colors.transparent,
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
          break;
         case kText:
             return Container(
              padding: EdgeInsets.fromLTRB(20.0, 4.0, 20.0, 4.0),
               child: Text(_fieldMap.fieldName,
                        style: Utility().returnTextStyle(Colors.white,14.0),
                        textAlign: TextAlign.center),
            );
      }
      return Container();
  }

 Future<void> navigateToPageWithIndex(int index,BuildContext context) async {
  switch (index) {
    case 8:
        Navigator.pushNamed(context, signWithEmailScreen);
         break; 
    case 4:
          navigateToPageWithURL(kFacebbok);
         break;
    case 6:
         navigateToPageWithURL(kGoogle);
         break;     
    case 12:
          Navigator.pop(context);
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
          return (index == 4 || index == 6) ? 48.0 : 30.0;
        case kLine:
          return 9.0;
      }
      return (index == 3 || index == 7) ? 10.0 :   30.0;
  }

  Future<void> navigateToPageWithURL(String url) async {
      if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
      }
  }
}

//MARK:- Field Type and Field Name
List<FieldMap> _returnFiledNames(){
   List<FieldMap> fieldMap = List();
   fieldMap.add(FieldMap(kImag,"Logo"));
   fieldMap.add(FieldMap(kContainer,""));
   fieldMap.add(FieldMap(kText,"GAIN BACK CONTROL OF YOUR LIFE"));
   fieldMap.add(FieldMap(kContainer,""));
   fieldMap.add(FieldMap(kButton,"SIGN UP WITH FACEBOOK"));
   fieldMap.add(FieldMap(kContainer,""));
   fieldMap.add(FieldMap(kButton,"SIGN UP WITH GOOGLE"));
   fieldMap.add(FieldMap(kContainer,""));
   fieldMap.add(FieldMap(kButton,"Sign up with Email address"));
   fieldMap.add(FieldMap(kContainer,""));
   fieldMap.add(FieldMap(kLine,""));
   fieldMap.add(FieldMap(kContainer,""));
   fieldMap.add(FieldMap(kButton,"Already have an account? Sign In"));
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