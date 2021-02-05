
import 'package:Amplify/App_Utility/Constant.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget{
  
  @override
  Widget build(BuildContext context){
      return Scaffold(
        appBar: AppBar(
          title:Text(LabelConstant.kHome),
          backgroundColor: Colors.black,
           elevation: 0,
            leading:IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () => {
                Navigator.of(context).pop()
              },
            )
        ),
      );
  }
}
