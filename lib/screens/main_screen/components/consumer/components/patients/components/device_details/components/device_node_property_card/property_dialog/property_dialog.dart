import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_net_frontend/models/device_node_property.dart';

import 'components/property_dialog_content.dart';

class PropertyDialog{
  final BuildContext context;

  PropertyDialog(this.context);

  void show(String deviceId, String deviceNodeId, DeviceNodeProperty property,String authToken){
    showDialog(
      context: context,
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: PropertyDialogContent(deviceId,deviceNodeId,authToken,property),
      )
      );
  }
}