import 'package:Amplify/App_Screens/HomeScreen.dart';
import 'package:Amplify/App_Screens/SignUpScreen.dart';
import 'package:Amplify/App_Screens/SignWithEmailScreen.dart';
import 'package:Amplify/App_Utility/Constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Amplify/App_Screens/LoginScreen.dart';


const String loginRoute = '/LoginScreen';
const String homeRoute = '/HomeScreen';
const String signUpRoute = '/SignUpScreen';
const String signWithEmailScreen = '/SignWithEmailScreen';

class AppRouter{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(builder: (_) => LoginScreen());
        break;
     case homeRoute:
        return MaterialPageRoute(builder: (_) => HomeScreen());
        break; 
     case signUpRoute:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
        break;  
     case signWithEmailScreen:
        return MaterialPageRoute(builder: (_) => SignWithEmailScreen());
        break;     
      default:
      return MaterialPageRoute(
                builder: (_) => Scaffold(
                    body:Center(
                      child:Text(LabelConstant.kNoRoute)),
                ));
    }
  }
}