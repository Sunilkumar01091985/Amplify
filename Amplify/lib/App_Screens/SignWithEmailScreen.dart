// ignore: must_be_immutable
import 'package:Amplify/App_Utility/Constant.dart';
import 'package:Amplify/App_Utility/FormValidator.dart';
import 'package:Amplify/App_Utility/Utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignWithEmailScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return SignWithEmailScreenState();
  }
}

class SignWithEmailScreenState extends State<SignWithEmailScreen>{
  List<FieldMap> _fieldNames = _returnFiledNames();
  int _selectedSection = 0;
  final TextEditingController  _dropDownTextEditingController = TextEditingController();
  final TextEditingController  _textEditingController = TextEditingController();
  Map<int,String> _radioGroupItem = {1 : "Male",2 : "Female",3 : "N/A"};
  List<String> _dropdownValues = ["Once a weak","Twice a weak","Every Day","Every month"];
  int _currentTimeValue = 0;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context){
      _fieldNames = (_selectedSection == 0) ? _returnFiledNames () : _returnSectionSectionFiledNames();
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
       body:  Form(
         key: _formKey,
         child: Container(
              color:Colors.black,
              child: Column(children: <Widget>[
                  Container(
                    child:returnHeaderSection(context)
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 280.0,
                    color:Colors.white,
                    child: new ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: _fieldNames.length,
                            itemBuilder: (BuildContext cntx,int index){
                              final _fieldMap = _fieldNames[index];
                              return Container(
                                child:_returnSubSectionWithIndex(index,_fieldMap,context),
                              );
                            }),
                  ),
                  Container(
                     padding: EdgeInsets.fromLTRB(20.0, 4.0, 20.0, 10.0),
                     height: 60.0,
                     color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      child: FlatButton(
                          child: Text(returnText(_selectedSection),style: Utility().returnTextStyle(Colors.black,14.0)),
                          onPressed: (){
                              navigateToPageWithIndex(1000, context);
                          },
                          color: Utility().hexToColor(kBackgroundColor),
                          textColor: Colors.black,
                          shape: StadiumBorder()
                      ),
                  )
              ],
            ),
            )
       )
      );
  }

  Container returnHeaderSection(BuildContext context){
    final containerWidth = (MediaQuery.of(context).size.width / 2.0) - 10.0;
    final  containerheight = 4.0;
    return Container(
      height: 100.0,
      padding: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      child: Column(children:<Widget>[
          Container(
            padding: EdgeInsets.only(left:8.0),
            child: Align(
              alignment :  Alignment.bottomLeft,
              child: Text(LabelConstant.kSignUp,
                   textAlign: TextAlign.right,
                   style: Utility().returnTextStyle(Utility().hexToColor(kBackgroundColor), 20.0),),
            )
         ),
         Container(
           height: 40.0,
           child: Container(
             child: Row(
               children: <Widget>[
                 Container(
                    width: containerWidth,
                    height: containerheight,
                   child: FlatButton(
                            onPressed: (){},
                            child: Container(
                              color:returnBackgroundColor(0)
                            ),
                    ),
                 ),
                 Container(
                    width: containerWidth,
                    height: containerheight,
                   child: FlatButton(
                            onPressed: (){},
                            child: Container(
                              color:returnBackgroundColor(1)
                            ),
                    ),
                 )
               ],
              )
           ),
         )
      ]
      )
    );
  }

 Container _returnSubSectionWithIndex(int index,FieldMap _fieldMap,BuildContext context){
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
              controller: _textEditingController,
              maxLength: (_selectedSection == 0) ? 25 :  8,
              style: Utility().returnTextStyle(Colors.black,14.0),
              decoration: InputDecoration(
              labelText:_fieldMap.fieldName,
              labelStyle: Utility().returnLabelStyle(),
              enabledBorder: Utility().returnBorderWithColor(Colors.black),
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
               return FormValidator().formValidationWithIndex(index, value,_selectedSection);
             },
            ),
          );
          break;
       case kText:
             return Container(
              padding: EdgeInsets.fromLTRB(20.0, 4.0, 20.0, 4.0),
               child: Text(_fieldMap.fieldName,
                        style: Utility().returnTextStyle(((_selectedSection == 0) ? Colors.black : (_selectedSection == 1 && index == 0) ?  Colors.black : Colors.red),14.0),
                        textAlign: TextAlign.left),
          );
          break;
        case kRadioGroup:
             final keys = _radioGroupItem.keys.toList();
             return Container(
              padding: EdgeInsets.fromLTRB(20.0, 4.0, 20.0, 4.0),
              child: new ListView(
                 physics: const NeverScrollableScrollPhysics(),
                 shrinkWrap: true,
                 children: keys.map((index) => RadioListTile(
                   activeColor: Utility().hexToColor(kBackgroundColor),
                   groupValue: _currentTimeValue,
                   title: Text(_radioGroupItem[index],
                               style: Utility().returnTextStyle(Colors.black,14.0)), 
                   value: index,
                    onChanged: (val){
                     setState(() {
                       _currentTimeValue = val;
                      });
                   }
                 )).toList()
              ),
             );
             break;
          case kDropDown:
           return Container(
             height: 60.0,
             padding: EdgeInsets.fromLTRB(20.0, 4.0, 20.0, 4.0),
             child: returnDropDownWith(context,_fieldMap)
           );   
      }
      return Container();
  }

 void navigateToPageWithIndex(int index,BuildContext context){
  switch (index) {
    case 8:
         if (_formKey.currentState.validate()) {
            
         }      
      break;
      case 1000:
        if (_formKey.currentState.validate()) {
            if(_selectedSection == 1){

            }else{
              _textEditingController.text = "";
              _selectedSection =  1;
              setState(() {});
            }
        }  
       break;
    case 16:
        //  Navigator.pushNamed(context, signUpRoute);
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
        case kRadioGroup:
          return 180.0;
        case kText:
          return 30.0;
        case kDropDown:
          return 74.0;  
      }
      return 10.0;
  }

  Color returnBackgroundColor(int _section){
     return (_section == _selectedSection) ? Utility().hexToColor(kBackgroundColor) : Colors.white;
  }

   String returnText(int _section){
       return _selectedSection == 0 ? "NEXT" : "CONTINUE";
  }

  //MARK:- Drop Down
  GestureDetector returnDropDownWith(BuildContext context,FieldMap _fieldMap){
    return GestureDetector(
            behavior: HitTestBehavior.translucent,
              onTap:()=>{
                    _returnDialogWithBuildContext(context,LabelConstant.kAppTitle)
              },
               child : Container(
        height: 60.0,
        child: new TextFormField(
          controller: _dropDownTextEditingController,
          style:Utility().returnTextStyle(Colors.black,14.0) ,
          autofocus: false,
          readOnly : true,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: _fieldMap.fieldName,
            labelStyle: Utility().returnLabelStyle(),
            contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 15.0),
            suffixIcon: new Icon(Icons.keyboard_arrow_down,color: Utility().hexToColor(kBackgroundColor)),
            border: new OutlineInputBorder(
              borderSide: new BorderSide(color: Colors.amber),
            ),
           enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color:Colors.black, width: 0.5),
            ),
            enabled : false
          ),
        ),
        )
    );
   }
 //MARK:- Dailog with Value
_returnDialogWithBuildContext(BuildContext context,String title){
  showDialog(
    context: context,
    builder: (BuildContext ctxt){
      return AlertDialog(
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0))),
        contentPadding: EdgeInsets.only(top: 9.0),
        content: StatefulBuilder(
          builder: (BuildContext altCntx,StateSetter setState){
            return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(0),
                height: 220.0,
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  children: _dropdownValues.map((data) => ListTile(
                    title: Text(data),
                    onTap: ()=>{
                      FocusScope.of(context).unfocus(),
                      Navigator.pop(context),
                      _dropDownTextEditingController.text = data
                    }
                  )).toList(),
                ),
              ),
            ],
          );
          }
        )
      );
    }
  );
  }
}
//MARK:- Field Type and Field Name
List<FieldMap> _returnFiledNames(){
   List<FieldMap> fieldMap = List();
   fieldMap.add(FieldMap(kText,"What your email address?"));
   fieldMap.add(FieldMap(kContainer,""));
   fieldMap.add(FieldMap(kTextField,"Email"));
   fieldMap.add(FieldMap(kContainer,""));
   fieldMap.add(FieldMap(kText,"What your gender?"));
   fieldMap.add(FieldMap(kContainer,""));
   fieldMap.add(FieldMap(kRadioGroup,""));
   fieldMap.add(FieldMap(kContainer,""));
   fieldMap.add(FieldMap(kText,"How much do you train?"));
   fieldMap.add(FieldMap(kContainer,""));
   fieldMap.add(FieldMap(kDropDown,"Select"));
   fieldMap.add(FieldMap(kContainer,""));
   return fieldMap;
}

List<FieldMap> _returnSectionSectionFiledNames(){
   List<FieldMap> fieldMap = List();
   fieldMap.add(FieldMap(kText,"Choose a password"));
   fieldMap.add(FieldMap(kContainer,""));
   fieldMap.add(FieldMap(kTextField,"Password"));
   fieldMap.add(FieldMap(kContainer,""));
   fieldMap.add(FieldMap(kTextField,"Confirm password"));
   fieldMap.add(FieldMap(kContainer,""));
   fieldMap.add(FieldMap(kText,"X Minimum of 8 charactors"));
   fieldMap.add(FieldMap(kContainer,""));
   fieldMap.add(FieldMap(kText,"X A capital letter"));
   fieldMap.add(FieldMap(kContainer,""));
   fieldMap.add(FieldMap(kText,"X A lowercase letter"));
   fieldMap.add(FieldMap(kContainer,""));
   fieldMap.add(FieldMap(kText,"X A number"));
   fieldMap.add(FieldMap(kContainer,""));
   fieldMap.add(FieldMap(kText,"X Both boxes match"));
   fieldMap.add(FieldMap(kContainer,""));
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
