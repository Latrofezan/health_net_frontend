import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_net_frontend/models/patient.dart';

class ErrorFlushBar {
  final Patient _patient;
  final int _statusCode;
  final BuildContext _context;
  Flushbar _flushBar;

  ErrorFlushBar(this._patient, this._context, this._statusCode) {
    _flushBar = Flushbar(
      margin: EdgeInsets.all(8).copyWith(top: 150),
      borderRadius: 8,
      flushbarPosition: FlushbarPosition.TOP,
      icon: Icon(
        Icons.error_outline,
        color: Theme.of(_context).backgroundColor,
        size: 30,
      ),
      title: "Error: " + _statusCode.toString(),
      message: _patient.fullName +
          " could not be registered due to a communication error",
      backgroundColor: Theme.of(_context).errorColor,
      duration: Duration(seconds: 5),
      mainButton: FlatButton(
        onPressed: () {
          _flushBar.dismiss(_patient);
        },
        child: Text("Retry"),
      ),
    );
  }

  Future<Patient> show() async {
    return await _flushBar.show(_context);
  }
}
