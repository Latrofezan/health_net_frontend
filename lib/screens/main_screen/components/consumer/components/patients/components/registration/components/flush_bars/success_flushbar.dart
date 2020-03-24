import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_net_frontend/models/patient.dart';

class SuccessFlushBar{
  final Patient _patient;
  final BuildContext _context;
  Flushbar _flushBar;

  SuccessFlushBar(this._patient, this._context){
    _flushBar= Flushbar(
    margin: EdgeInsets.all(8).copyWith(top:150),
    borderRadius: 8,
    flushbarPosition: FlushbarPosition.TOP,
    icon: Icon(Icons.check_circle_outline,color:Theme.of(_context).backgroundColor,size: 30,),
    title: "Patient registration completed",
    message:_patient.fullName+" has been registered",
    backgroundColor: Colors.green[700],
    duration: Duration(seconds:5), 
  );
  }

  void show(){
    _flushBar.show(_context);
  }
}