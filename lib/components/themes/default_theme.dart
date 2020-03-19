import 'package:flutter/material.dart';

class HealthNetDefaultTheme{
  static var theme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.indigo,
    primaryColorLight: Colors.cyan,
    accentColor: Colors.green,
    backgroundColor: Colors.white,
    disabledColor: Colors.grey,
    errorColor: Colors.orange,

    buttonColor: Colors.green,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.indigo,
      
      errorStyle: TextStyle(
        color:Colors.orange
      ),
      border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color:Colors.white,width: 2),
        borderRadius: BorderRadius.circular(25),
      ),

      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color:Colors.lightGreen,width: 3),
        borderRadius: BorderRadius.circular(25),
      ),

      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color:Colors.orange,width: 3),
        borderRadius: BorderRadius.circular(25),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color:Colors.orange,width: 3),
        borderRadius: BorderRadius.circular(25),
      ),

    ),


  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.normal,
    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(25.0)),
    
  )
    );
}