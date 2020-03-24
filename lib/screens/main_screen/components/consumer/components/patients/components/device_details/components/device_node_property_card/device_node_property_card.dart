import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_net_frontend/models/device_node_property.dart';

import 'property_dialog/property_dialog.dart';

class DeviceNodePropertyCard extends StatelessWidget {
  final String deviceId;
  final String deviceNodeId;
  final String authToken;
  final DeviceNodeProperty deviceNodeProperty;

  const DeviceNodePropertyCard(
      this.deviceId, this.deviceNodeId, this.deviceNodeProperty,this.authToken,
      {Key key})
      : super(key: key);
  @override
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
            PropertyDialog(context).show(deviceId, deviceNodeId, deviceNodeProperty, authToken);
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
                child: Icon(Icons.details,
                    size: 20, color: Theme.of(context).accentColor),
              )
            ],
          ),
        ));
  }
}
