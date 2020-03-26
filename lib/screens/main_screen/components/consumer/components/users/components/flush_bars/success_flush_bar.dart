import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:health_net_frontend/models/user.dart';

class SuccessFlushBar{
  final User _user;
  final BuildContext _context;
  Flushbar _flushBar;

  SuccessFlushBar(this._user, this._context){
    _flushBar= Flushbar(
    margin: EdgeInsets.all(8).copyWith(top:200),
    borderRadius: 8,
    flushbarPosition: FlushbarPosition.TOP,
    icon: Icon(Icons.check_circle_outline,color:Theme.of(_context).backgroundColor,size: 30,),
    title: "Patient registration completed",
    message:_user.name+" has been registered",
    backgroundColor: Colors.green[700],
    duration: Duration(seconds:5), 
  );
  }

  void show(){
    _flushBar.show(_context);
  }
}