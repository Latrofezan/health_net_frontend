import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_net_frontend/blocs/main_screen/patients_management/bloc/patients_bloc.dart';
import 'package:health_net_frontend/screens/main_screen/components/consumer/components/patients/components/consumer/patients_screen_consumer.dart';

class PatientsScreen extends StatelessWidget {
  final double height;
  final double width;

  const PatientsScreen(this.height, this.width, {Key key}) : super(key: key);
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        child: BlocProvider.value(
          value: BlocProvider.of<PatientsBloc>(context),
          child: PatientsScreenConsumer(),
        ));
  }
}
