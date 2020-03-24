import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_net_frontend/models/patient.dart';

class UnfetchedDevicesDialogContent extends StatelessWidget {
  final Map<Patient, int> devicesErrors;

  const UnfetchedDevicesDialogContent(this.devicesErrors, {Key key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        width: 300,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //crossAxisAlignment: CrossAxisAlignment.s,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: Theme.of(context).errorColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text("Warning: Devices Unfetched",
                    style: Theme.of(context).textTheme.title),
              ),
            ),
            Flexible(
              child: Text(
                "Couldn't obtain devices for the following patients due to connectivity issues:",
                style: Theme.of(context).textTheme.title.copyWith(
                    color: Colors.black54, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            SingleChildScrollView(
                child: Column(
              children: devicesErrors.keys
                  .map((entry) => Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          entry.fullName,
                          style: Theme.of(context)
                              .textTheme
                              .subhead
                              .copyWith(color: Theme.of(context).primaryColor),
                        ),
                      ))
                  .toList(),
            )),
            Padding(
                padding: EdgeInsets.all(8),
                child: Text("Do you want to try again?")),
            Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                      color: Theme.of(context).buttonColor,
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: Text(" Yes")),
                  FlatButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                      color: Theme.of(context).buttonColor,
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Text(" No "))
                ],
              ),
            )
          ],
        ));
    ;
  }
}
