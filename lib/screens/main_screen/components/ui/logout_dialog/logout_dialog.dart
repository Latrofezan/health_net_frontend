import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/logout_dialog_content.dart';

class LogoutDialog {
  static Future<bool> show(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        //shape: BoxShape.rectangle,
        child:LogOutDialogContent(),
      )
    );
  }
}
