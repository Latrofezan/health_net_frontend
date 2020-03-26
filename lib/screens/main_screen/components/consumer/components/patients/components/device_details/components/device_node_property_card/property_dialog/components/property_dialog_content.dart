import 'dart:collection';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_net_frontend/models/device_node_property.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class PropertyDialogContent extends StatefulWidget {
  final DeviceNodeProperty property;
  final WebSocketChannel getWebSocket;
  final WebSocketChannel setWebSocket;

  const PropertyDialogContent(
      this.property, this.getWebSocket, this.setWebSocket,
      {Key key})
      : super(key: key);

  @override
  State<PropertyDialogContent> createState() => _PropertyDialogContentState();
}

class _PropertyDialogContentState extends State<PropertyDialogContent> {
  var _propertyController=TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(32),
        ),
        height: 200,
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(widget.property.name + " setter",
                    style: Theme.of(context).textTheme.title),
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal:8,vertical:2), child: TextField(
              controller: _propertyController,
              decoration: InputDecoration(
                labelText:"set property"
              ).applyDefaults(Theme.of(context).inputDecorationTheme),
            )),
            Padding(padding: EdgeInsets.only(bottom: 8), child: FlatButton(
              onPressed: (){
                widget.setWebSocket.sink.add(_propertyController.text);
                Navigator.of(context).pop();
              },
              padding: EdgeInsets.symmetric(horizontal:50,vertical:12),
              color: Theme.of(context).buttonColor,
              child: Text("edit"))),
          ],
        ));
  }

  /*_updateQueueValues(String value) {
    setState(() {
      if (value != null && _values.length >= 10) _values.removeFirst();
      _values.addLast(value);
    });
  }*/
}
