import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:health_net_frontend/models/user.dart';
import 'package:health_net_frontend/screens/main_screen/components/consumer/components/users/components/registration/users_registration_data.dart';

class ErrorFlushBar {
  final UsersRegistrationData _tentative;
  final int _statusCode;
  final BuildContext _context;
  Flushbar _flushBar;

  ErrorFlushBar(this._tentative, this._context, this._statusCode) {
    _flushBar = Flushbar(
      margin: EdgeInsets.all(8).copyWith(top: 200),
      borderRadius: 8,
      flushbarPosition: FlushbarPosition.TOP,
      icon: Icon(
        Icons.error_outline,
        color: Theme.of(_context).backgroundColor,
        size: 30,
      ),
      title: "Error: " + _statusCode.toString(),
      message: _tentative.user.name +
          " could not be registered due to a communication error",
      backgroundColor: Theme.of(_context).errorColor,
      duration: Duration(seconds: 5),
      mainButton: FlatButton(
        onPressed: () {
          _flushBar.dismiss(_tentative);
        },
        child: Text("Retry"),
      ),
    );
  }

  Future<UsersRegistrationData> show() async {
    return await _flushBar.show(_context);
  }
}
