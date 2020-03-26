import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_net_frontend/models/device_node_property.dart';
import 'package:health_net_frontend/services/components/API_interfaces.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'property_dialog/property_dialog.dart';

class DeviceNodePropertyCard extends StatelessWidget {
  final String deviceId;
  final String deviceNodeId;
  final String authToken;
  final DeviceNodeProperty deviceNodeProperty;
  final WebSocketChannel getWebSocket;
  final WebSocketChannel setWebSocket;

  const DeviceNodePropertyCard._private(
      this.deviceId,
      this.deviceNodeId,
      this.deviceNodeProperty,
      this.authToken,
      this.getWebSocket,
      this.setWebSocket,
      {Key key})
      : super(key: key);

  factory DeviceNodePropertyCard(String deviceId, String deviceNodeId,
      String authToken, DeviceNodeProperty property) {
    return DeviceNodePropertyCard._private(
        deviceId,
        deviceNodeId,
        property,
        authToken,
        IOWebSocketChannel.connect(
            "ws://" +
                APIInterfaces.getDevicesWebSocketsURl() +
                "/" +
                deviceId +
                "/" +
                deviceNodeId +
                "/" +
                property.id,
            headers: {HttpHeaders.authorizationHeader: authToken}),
        (property.settable)
            ? IOWebSocketChannel.connect(
                "ws://" +
                    APIInterfaces.getDevicesWebSocketsURl() +
                    "/" +
                    deviceId +
                    "/" +
                    deviceNodeId +
                    "/" +
                    property.id +
                    "/set",
                headers: {HttpHeaders.authorizationHeader: authToken})
            : null);
  }
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(8)),
            border:
                Border.all(color: Theme.of(context).backgroundColor, width: 2)),
        child: InkWell(
          onTap: () {
            if(deviceNodeProperty.settable)
              PropertyDialog(context).show(getWebSocket, setWebSocket, deviceNodeProperty);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(Icons.settings_input_component,
                      color: Theme.of(context).backgroundColor, size: 30)),
              Padding(
                  padding: EdgeInsets.all(4),
                  child: Text(
                    deviceNodeProperty.name,
                    style: Theme.of(context).textTheme.subhead,
                  )),
              Padding(
                padding: EdgeInsets.all(4),
                child: StreamBuilder(
                    stream: getWebSocket.stream,
                    builder: (context, snapshot) {
                      return Text(
                        (snapshot.hasData) ? snapshot.data : "-",
                        style: Theme.of(context)
                            .textTheme
                            .body1
                            ,
                      );
                    }),
              )
            ],
          ),
        ));
  }
}
