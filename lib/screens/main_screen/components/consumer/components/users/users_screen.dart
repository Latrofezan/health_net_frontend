import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_net_frontend/blocs/main_screen/users_management/bloc/users_bloc.dart';

import 'components/consumer/users_screen_consumer.dart';

class UsersScreen extends StatelessWidget {
  final double height;
  final double width;
  const UsersScreen(this.height, this.width, {Key key}) : super(key: key);
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: width,
        child: BlocProvider.value(
          value: BlocProvider.of<UsersBloc>(context),
          child: BlocProvider.value(
            value: BlocProvider.of<UsersBloc>(context),
            child: UsersScreenConsumer(),
            ),
        ));
  }
}