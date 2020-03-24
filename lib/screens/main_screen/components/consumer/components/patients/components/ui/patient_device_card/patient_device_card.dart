import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_net_frontend/models/device.dart';
import 'package:health_net_frontend/models/patient.dart';
import 'package:health_net_frontend/screens/main_screen/components/consumer/components/patients/components/device_details/device_details.dart';

class PatientDeviceCard extends StatelessWidget {
  final String authToken;
  final Patient patient;
  final Device device;

  const PatientDeviceCard(this.patient, this.device,this.authToken,{Key key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(4)),
            border: Border.all(color: Theme.of(context).backgroundColor, width: 2)),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DeviceDetailsScreen(patient,device,authToken)));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(4),
                  child: Icon(Icons.settings_input_component,
                      color: Theme.of(context).backgroundColor, size: 30)),
              Column(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(4),
                      child: Text(
                        device.name,
                        style: Theme.of(context).textTheme.subhead,
                      )),
                  Padding(
                      padding: EdgeInsets.all(4),
                      child: Text(
                        device.nodes.length.toString()+" nodes found",
                        style: Theme.of(context).textTheme.subhead,
                      )),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(4),
                child: Icon(Icons.details,size:25,color:Theme.of(context).accentColor),
              )
            ],
          ),
        ));
  }
}
