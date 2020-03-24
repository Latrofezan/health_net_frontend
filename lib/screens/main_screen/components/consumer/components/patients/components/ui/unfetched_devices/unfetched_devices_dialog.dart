import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_net_frontend/models/patient.dart';

import 'components/unfetched_devices_dialog_content.dart';

class UnfetchedDevicesDialog {
  final BuildContext context;

  UnfetchedDevicesDialog(this.context);

  Future<bool> show(Map<Patient, int> devicesErrors) async {
    return await showDialog(
        context: context,
        barrierDismissible: false,
        child: WillPopScope(
            child: Dialog(
              backgroundColor: Colors.transparent,
              child: UnfetchedDevicesDialogContent(devicesErrors),
            ),
            onWillPop: () async => false));

  }
}
