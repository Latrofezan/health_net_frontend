import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_net_frontend/blocs/authentication/authentication_bloc.dart';

import 'components/consumer/login_screen_consumer.dart';
class LoginScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body:BlocProvider.value(
        value: BlocProvider.of<AuthenticationBloc>(context),
        child: AuthenticationConsumer(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),)
    );
  }

}