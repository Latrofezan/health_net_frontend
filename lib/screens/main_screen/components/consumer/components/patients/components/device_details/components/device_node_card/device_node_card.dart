import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_net_frontend/models/device_node.dart';
import 'package:health_net_frontend/screens/main_screen/components/consumer/components/patients/components/device_details/components/device_node_property_card/device_node_property_card.dart';

class DeviceNodeCard extends StatefulWidget {
  final String deviceId;
  final String authToken;
  final DeviceNode deviceNode;


  DeviceNodeCard(this.deviceId,this.deviceNode,this.authToken,{Key key}) : super(key: key);

  @override
  State<DeviceNodeCard> createState() => _PatientCardState();
}

class _PatientCardState extends State<DeviceNodeCard> {
  bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius:
                BorderRadius.all(Radius.circular(16)),
            border:
                Border.all(color:(_isExpanded)?Theme.of(context).accentColor:Theme.of(context).backgroundColor, width: 2)),
        child: ExpansionTile(
          title: Container(
              height: 70,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 25),
                      child: Icon(Icons.play_for_work,color:(_isExpanded)?Theme.of(context).accentColor:Theme.of(context).backgroundColor, size: 40),
                    ),
                    Flexible(
                      child:Text(
                      this.widget.deviceNode.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    )),
                  ],
                ),
              )),
          trailing: (_isExpanded)
              ? Icon(
                  Icons.arrow_drop_down,
                  color: Theme.of(context).accentColor,
                  size: 40,
                )
              : Icon(
                  Icons.arrow_right,
                  color: Theme.of(context).backgroundColor,
                  size: 40,
                ),
          onExpansionChanged: (value) {
            setState(() {
              _isExpanded = value;
            });
          },
          children:widget.deviceNode.properties.map(
            (property)=>Padding(
              padding: EdgeInsets.all(4),
              child: DeviceNodePropertyCard(widget.deviceId, widget.deviceNode.id,widget.authToken,property)
              )
            ).toList()
        ));
  }
}
