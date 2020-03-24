import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_net_frontend/blocs/main_screen/patients_management/bloc/patients_bloc.dart';

class PatientsConnectionError extends StatelessWidget {
  final int code;

  const PatientsConnectionError(this.code, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15),
            child: Icon(
              Icons.sentiment_dissatisfied,
              size: 50,
              color: Theme.of(context).errorColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Text("Error " + code.toString(),
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(color: Theme.of(context).errorColor)),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Text(
                "An Error has occurred while tryng to reach the devices server",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(color: Theme.of(context).errorColor)),
          ),
          Padding(
              padding: EdgeInsets.all(20),
              child: IconButton(
                  icon: Icon(Icons.refresh,
                      size: 40, color: Theme.of(context).backgroundColor),
                  color: Theme.of(context).errorColor,
                  onPressed: () {
                    BlocProvider.of<PatientsBloc>(context)
                        .add(PatientsFetchingRequired(true));
                  })),
        ]));
  }
}
