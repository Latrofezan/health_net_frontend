import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_net_frontend/models/device_node_property.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'components/property_dialog_content.dart';

class PropertyDialog{
  final BuildContext context;

  PropertyDialog(this.context);

  void show(WebSocketChannel getter,WebSocketChannel setter,  DeviceNodeProperty property){
    showDialog(
      context: context,
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: PropertyDialogContent(property, getter,setter),
      )
      );
  }
}