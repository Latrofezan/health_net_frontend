import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_net_frontend/models/device.dart';
import 'package:health_net_frontend/models/patient.dart';

import 'components/device_node_card/device_node_card.dart';

class DeviceDetailsScreen extends StatelessWidget {
  final Patient patient;
  final Device device;
  final String authToken;

  const DeviceDetailsScreen(this.patient, this.device,this.authToken,{Key key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(device.name.toUpperCase()),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
            icon: Icon(Icons.arrow_back,
                size: 30, color: Theme.of(context).backgroundColor),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8),
            child: Container(
                height: 150,
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  border: Border.all(
                      color: Theme.of(context).backgroundColor, width: 3),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Patient Name:"),
                          Flexible(child: Text(patient.fullName)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Device Name:"),
                          Text(device.name),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Device nodes count:"),
                          Text(device.nodes.length.toString()),
                        ],
                      ),
                    ])),
          ),
          Expanded(
            child: Padding(
                padding: EdgeInsets.all(8),
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                      return Padding(
                          padding: EdgeInsets.all(4),
                          child:
                              DeviceNodeCard(device.id, device.nodes[index],authToken));
                    }, childCount: device.nodes.length))
                  ],
                )),
          )
        ],
      ),
    );
  }
}
