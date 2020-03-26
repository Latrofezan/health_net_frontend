import 'dart:collection';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_net_frontend/models/device_node_property.dart';
import 'package:health_net_frontend/services/components/API_interfaces.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class PropertyDialogContent extends StatefulWidget {
  final String deviceId;
  final String deviceNodeId;
  final DeviceNodeProperty property;
  final String authToken;
  final WebSocketChannel getWebSocket;
  final WebSocketChannel setWebSocket;

  const PropertyDialogContent._private(this.deviceId, this.deviceNodeId,
      this.property, this.authToken, this.getWebSocket, this.setWebSocket,
      {Key key})
      : super(key: key);

  factory PropertyDialogContent(
    String deviceId,
    String deviceNodeId,
    String authToken,
    DeviceNodeProperty nodeProperty,
  ) {
    return PropertyDialogContent._private(
        deviceId,
        deviceNodeId,
        nodeProperty,
        authToken,
        IOWebSocketChannel.connect(
            "ws://" +
                APIInterfaces.getDevicesWebSocketsURl() +
                "/" +
                deviceId +
                "/" +
                deviceNodeId +
                "/" +
                nodeProperty.id,
            headers: {HttpHeaders.authorizationHeader: authToken}),
        (nodeProperty.settable)
            ? IOWebSocketChannel.connect(
                "ws://" +
                    APIInterfaces.getDevicesWebSocketsURl() +
                    "/" +
                    deviceId +
                    "/" +
                    deviceNodeId +
                    "/" +
                    nodeProperty.id +
                    "/set",
                headers: {HttpHeaders.authorizationHeader: authToken})
            : null);
  }
  @override
  State<PropertyDialogContent> createState() => _PropertyDialogContentState();
}

class _PropertyDialogContentState extends State<PropertyDialogContent> {
  Queue<String> _values;

  @override
  void initState() {
    print( "ws://" +
                APIInterfaces.getDevicesWebSocketsURl() +
                "/" +
                widget.deviceId +
                "/" +
                widget.deviceNodeId +
                "/" +
                widget.property.id,);
    _values = Queue<String>();
    _values.add("");
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
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(32),
        ),
        height: 200,
        width: 250,
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
                child: Text(widget.property.name,
                    style: Theme.of(context).textTheme.title),
              ),
            ),
            Expanded(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "value: ",
                      style: Theme.of(context)
                          .textTheme
                          .title
                          .copyWith(color: Theme.of(context).primaryColor),
                    ),
                    StreamBuilder(
                        stream: widget.getWebSocket.stream,
                        builder: (context, snapshot) {
                          return Text(
                            (snapshot.hasData) ? snapshot.data : "-",
                            style: Theme.of(context).textTheme.title.copyWith(
                                color: Theme.of(context).primaryColor),
                          );
                        })
                  ]),
            ),
            (widget.property.settable)?Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                children:<Widget>[
                  IconButton(
                    color: Theme.of(context).accentColor,
                    icon: Icon(Icons.arrow_upward,size:25,color: Theme.of(context).backgroundColor,),
                    onPressed: ()=>widget.setWebSocket.sink.add('increase test')),
                  IconButton(
                    color: Theme.of(context).accentColor,
                    icon: Icon(Icons.arrow_downward,size:25,color: Theme.of(context).backgroundColor,),
                    onPressed: ()=>widget.setWebSocket.sink.add('increase test')),
                ]
              ),
            ):Container(height: 0.0,width: 0.0),
          ],
        ));
  }

  _updateQueueValues(String value) {
    setState(() {
      if (value != null && _values.length >= 10) _values.removeFirst();
      _values.addLast(value);
    });
  }
}
