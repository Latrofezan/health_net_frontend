import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:health_net_frontend/blocs/main_screen/bloc/main_screen_bloc.dart';
import 'package:health_net_frontend/blocs/main_screen/patients_management/bloc/patients_bloc.dart';
import 'package:health_net_frontend/blocs/main_screen/users_management/bloc/users_bloc.dart';
import 'package:health_net_frontend/screens/main_screen/components/consumer/components/users/users_screen.dart';
import 'package:health_net_frontend/screens/main_screen/components/ui/logout_dialog/logout_dialog.dart';

import 'components/patients/patients_screen.dart';

class MainScreenConsumer extends StatelessWidget {
  final String _authEmail;

  const MainScreenConsumer(this._authEmail, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(child:
        BlocBuilder<MainScreenBloc, MainScreenState>(builder: (context, state) {
      if (state is PatientsScreenSelected) {
        var bloc =
            PatientsBloc(state.patientRepository, state.devicesRepository);
        bloc.add(PatientsFetchingRequired(false));
        return BlocProvider(
          create: (context) => bloc,
          child: PatientsScreen(
            MediaQuery.of(context).size.height,
            MediaQuery.of(context).size.width,
          ),
        );
      }

      if (state is UsersScreenSelected) {
        var bloc = UsersBloc(state.usersRepository, _authEmail);
        bloc.add(UsersFetchingRequired(false));
        return BlocProvider(
          create: (context) => bloc,
          child: UsersScreen(
            MediaQuery.of(context).size.height,
            MediaQuery.of(context).size.width,
          ),
        );
      }
    }), onWillPop: () async {
      var result = await LogoutDialog.show(context);
      FlutterSecureStorage secureStorage = FlutterSecureStorage();
      if (result) {
        await secureStorage.delete(key: 'authToken');
        await secureStorage.delete(key: 'authMail');
        Navigator.of(context).pushReplacementNamed('login');
      }
      return false;
    });
  }
}
