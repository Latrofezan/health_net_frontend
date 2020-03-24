import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_net_frontend/blocs/authentication/authentication_bloc.dart';
import 'package:health_net_frontend/blocs/main_screen/bloc/main_screen_bloc.dart';
import 'package:health_net_frontend/screens/login_screen/login_screen.dart';
import 'package:health_net_frontend/screens/main_screen/components/arguments/main_screen_arguments.dart';
import 'package:health_net_frontend/screens/main_screen/main_screen.dart';

import 'components/themes/default_theme.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: HealthNetDefaultTheme.theme,
      initialRoute: 'login',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case 'login':
            {
              return MaterialPageRoute(builder: (context) {
                return BlocProvider(
                    create: (BuildContext context) => AuthenticationBloc(),
                    child: LoginScreen());
              });
            }
            break;

          case 'main':
            {
              final MainScreenArguments args = settings.arguments;
              return MaterialPageRoute(builder: (context) {
                return BlocProvider(
                  create: (BuildContext context)=>MainScreenBloc(args.repository),
                  child:MainScreen(args.email));
              });
            }
            break;
        }
      },
    );
  }
}
