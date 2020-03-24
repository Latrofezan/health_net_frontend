import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_net_frontend/models/patient.dart';
import 'package:uuid/uuid.dart';

class PatientRegistrationForm extends StatefulWidget {
  final double height;
  final double width;

  const PatientRegistrationForm({Key key, this.height, this.width})
      : super(key: key);
  @override
  State<PatientRegistrationForm> createState() =>
      _PatientRegistrationFormState();
}

class _PatientRegistrationFormState extends State<PatientRegistrationForm> {
  var _patientNameController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  bool _error;

  @override
  void initState() {
    _error = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? 300,
      width: widget.width ?? 300,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            //title
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
                child: Text("Register a new patient",
                    style: Theme.of(context).textTheme.title),
              ),
            ),

            //input
            Padding(
              padding: EdgeInsets.symmetric(horizontal:8),
              child: TextFormField(
              controller: _patientNameController,
              validator: (value) {
                if (value.isEmpty) {
                  setState(() {
                    _error = true;
                  });
                  return 'insert a name';
                }
                setState(() {
                  _error = false;
                });
                return null;
              },
              decoration: InputDecoration(
                labelText: 'patient name',
                prefixIcon: Icon(
                  Icons.lock,
                  size: 30,
                  color: (_error) ? Theme.of(context).errorColor : null,
                ),
              ).applyDefaults(Theme.of(context).inputDecorationTheme),
            ),
              ),

            Padding(
                padding: EdgeInsets.all(8),
                child: FlatButton(
                  padding: EdgeInsets.symmetric(horizontal:24, vertical:12),
                  color: Theme.of(context).buttonColor,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Navigator.of(context).pop(Patient(Uuid().v4(), _patientNameController.text)) ;
                    }
                  },
                  child: Text("Register"),
                ))
          ],
        ),
      ),
    );
  }
}
