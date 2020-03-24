import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_net_frontend/blocs/main_screen/patients_management/bloc/patients_bloc.dart';
import 'package:health_net_frontend/components/ui/loading_element/loading_element.dart';
import 'package:health_net_frontend/models/device.dart';
import 'package:health_net_frontend/models/patient.dart';
import 'package:health_net_frontend/screens/main_screen/components/consumer/components/patients/components/ui/patient_device_card/patient_device_card.dart';

class PatientCard extends StatefulWidget {
  final Patient patient;

  PatientCard(this.patient, {Key key}) : super(key: key);

  @override
  State<PatientCard> createState() => _PatientCardState();
}

class _PatientCardState extends State<PatientCard> {
  bool _isExpanded;
  bool _isLoading;
  List<Device> _devices;
  int _devicesFetchingStatusCode;
  @override
  void initState() {
    _devices = List<Device>();
    _isExpanded = false;
    _isLoading = true;
    _devicesFetchingStatusCode = 200;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border: Border.all(
              color: (_isExpanded)
                  ? Theme.of(context).accentColor
                  : Theme.of(context).backgroundColor,
              width: 2)),
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
                      child: Icon(Icons.person_pin,
                          color: (_isExpanded)
                              ? Theme.of(context).accentColor
                              : Theme.of(context).backgroundColor,
                          size: 40),
                    ),
                    Flexible(
                        child: Text(
                      this.widget.patient.fullName,
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
          onExpansionChanged: (value) async {
            await _expandedUpdate(value);
          },
          children: (_devices.isNotEmpty)
              ? _devices
                  .map((device) => Padding(
                        padding: EdgeInsets.all(4),
                        child: PatientDeviceCard(
                            widget.patient,
                            device,
                            BlocProvider.of<PatientsBloc>(context)
                                .devicesRepository
                                .authToken),
                      ))
                  .toList()
              : (_devicesFetchingStatusCode < 200 &&
                      _devicesFetchingStatusCode >= 400)
                  ? <Widget>[
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      "Error " +
                                          _devicesFetchingStatusCode.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .title
                                          .copyWith(
                                              color:
                                                  Theme.of(context).errorColor),
                                    ),
                                    Text("Devices could not be fetched",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .errorColor))
                                  ],
                                ),
                              )))
                    ]
                  : (_isLoading)
                      ? <Widget>[
                          Container(
                              height: 80,
                              child: LoadingElement(
                                radius: 30,
                              ))
                        ]
                      : <Widget>[
                          Container(
                              height: 80,
                              child: Center(
                                  child: Text(
                                      "No devices found for this patient")))
                        ]),
    );
  }

  Future<void> _expandedUpdate(bool value) async {
    setState(() {
      _isExpanded = value;
    });
    var result;
    if (value && _devices.isEmpty) {
      setState(() {
        _isLoading = true;
      });
      result = await BlocProvider.of<PatientsBloc>(context)
          .devicesRepository
          .get(widget.patient);
      setState(() {
        _isLoading = false;
        if (result is int) _devicesFetchingStatusCode = result;
        if (result is List<Device>) {
          _devices = result;
          _devicesFetchingStatusCode = 200;
        }
      });
    }

  }
}
