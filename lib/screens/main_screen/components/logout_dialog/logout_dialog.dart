import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogoutDialog {
  static Future<bool> show(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
          title: Text("LogOut"),
          content: Text("do you want to logout?"),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text("No")),
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text("Yes"))
          ]),
    );
  }
}
