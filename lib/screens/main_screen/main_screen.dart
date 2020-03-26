import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_net_frontend/blocs/main_screen/bloc/main_screen_bloc.dart';
import 'package:health_net_frontend/screens/main_screen/components/consumer/main_screen_consumer.dart';
import 'package:health_net_frontend/screens/main_screen/components/ui/bottomAppBar/bottom_appBar.dart';

import 'components/ui/actionButton/action_button.dart';
class MainScreen extends StatelessWidget{
  final String _email;
  const MainScreen(this._email,{Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Theme.of(context).backgroundColor,
      //BLoC needed
      body:BlocProvider.value(
        value: BlocProvider.of<MainScreenBloc>(context),
        child:MainScreenConsumer(_email)),

      bottomNavigationBar:BlocProvider.value(
        value: BlocProvider.of<MainScreenBloc>(context),
        child:HealthNetBottomAppBar(),),
      
      floatingActionButton: BlocProvider.value(
        value: BlocProvider.of<MainScreenBloc>(context),
        child: HealthNetActionButton(),
        ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
      }
      
    }