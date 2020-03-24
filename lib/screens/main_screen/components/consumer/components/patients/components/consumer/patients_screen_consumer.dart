import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_net_frontend/blocs/main_screen/patients_management/bloc/patients_bloc.dart';
import 'package:health_net_frontend/components/ui/loading_dialog/loading_dialog.dart';
import 'package:health_net_frontend/screens/main_screen/components/consumer/components/patients/components/ui/app_bar.dart';
import 'package:health_net_frontend/screens/main_screen/components/consumer/components/patients/components/ui/error_screen/error_screen.dart';
import 'package:health_net_frontend/screens/main_screen/components/consumer/components/patients/components/ui/patients_card_list/patients_card_list.dart';
import 'package:health_net_frontend/screens/main_screen/components/consumer/components/patients/components/ui/unfetched_devices/unfetched_devices_dialog.dart';

class PatientsScreenConsumer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PatientsBloc, PatientsState>(
      listener: (context, state) async {
        LoadingDialog.hide(context);

        if (state is PatientsFetching) {
          LoadingDialog.show(context);
        }
      },
      builder: (context, state) {
        if (state is PatientsFetchingSuccess) {
          return Column(children: <Widget>[
            PatientsAppBar(
              searchBarController: state.searchBarController,
              height: 160,
            ),
            Expanded(child: Container(
                margin: EdgeInsets.symmetric(horizontal:8,vertical:8),
                child:BlocProvider.value(
                  value: BlocProvider.of<PatientsBloc>(context),
                  child: PatientsCardList(
                      state.searchBarController, state.patients),
                ))),
           
          ]);
        }

        if(state is PatientsFetching){
          return Column(
            children: <Widget>[
               PatientsAppBar(
              height: 160,
            ),
          ],);
        }

        if (state is PatientsFetchingFailed) {
          return BlocProvider.value(
            value: BlocProvider.of<PatientsBloc>(context),
            child: PatientsConnectionError(state.patientsFetchingstatusCode),
          );
        }
        return Container(height: 0.0, width: 0.0,);
      },
    );
  }
}
