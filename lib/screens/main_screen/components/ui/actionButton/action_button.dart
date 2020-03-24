import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_net_frontend/blocs/main_screen/bloc/main_screen_bloc.dart';
import 'package:health_net_frontend/screens/main_screen/components/consumer/components/patients/components/registration/patients_registration_dialog.dart';


class HealthNetActionButton extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainScreenBloc,MainScreenState>(
      builder:(context,state){
        if(state is PatientsScreenSelected){
          return FloatingActionButton(
          child: Icon(Icons.add,size: 40, color: Theme.of(context).backgroundColor,),
          backgroundColor: Theme.of(context).accentColor,
          onPressed:() async {
            await PatientsRegistrationDialog(context, state.patientRepository).show();
          },
        );
        }

        if(state is UsersScreenSelected){
           return FloatingActionButton(
          child: Icon(Icons.add,size: 40, color: Theme.of(context).backgroundColor,),
          backgroundColor: Theme.of(context).accentColor,
          onPressed:(){},
        );
        }
      });
  }
}