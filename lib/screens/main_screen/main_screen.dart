import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_net_frontend/models/user.dart';
import 'package:health_net_frontend/repository/repository.dart';
import 'package:health_net_frontend/screens/main_screen/components/consumer/main_screen_consumer.dart';
import 'package:health_net_frontend/screens/main_screen/components/logout_dialog/logout_dialog.dart';

class MainScreen extends StatelessWidget{
  final String _email;
  final HealthNetRepository _repository;

  const MainScreen(this._email,this._repository,{Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //BLoC needed
      body:MainScreenConsumer(),
    );
  }
  
}