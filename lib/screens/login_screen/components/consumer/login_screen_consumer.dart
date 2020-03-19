import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_net_frontend/blocs/authentication/authentication_bloc.dart';
import 'package:health_net_frontend/components/ui/loading_dialog/loading_dialog.dart';
import 'package:health_net_frontend/components/ui/loading_element/loading_element.dart';
import 'package:health_net_frontend/components/ui/logo/healthnet_logo.dart';
import 'package:health_net_frontend/screens/login_screen/components/ui/login_form/login_form.dart';
import 'package:health_net_frontend/screens/main_screen/components/arguments/main_screen_arguments.dart';

class AuthenticationConsumer extends StatefulWidget {
  final double height;
  final double width;

  const AuthenticationConsumer({Key key, this.height, this.width}) : super(key: key);

  @override
  State<AuthenticationConsumer> createState()=>_AuthenticationConsumerState();
    
    }
  
  class _AuthenticationConsumerState extends State<AuthenticationConsumer>{
@override
  void initState() {
    super.initState();
    BlocProvider.of<AuthenticationBloc>(context).add(AppStarted());
  }

    @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Theme.of(context).primaryColor,
          Theme.of(context).primaryColorLight
        ],
        begin: FractionalOffset.topCenter,
        end: FractionalOffset.bottomCenter,
      )),
      child: BlocConsumer<AuthenticationBloc, AuthenticationState>(

        listener: (context, state) {
          if (state is AuthenticationFailed) {
            BlocProvider.of<AuthenticationBloc>(context).add(AppStarted());
            LoadingDialog.hide(context);
            Flushbar(
              message: "Invalid credentials. Please, try again",
              icon: Icon(
                Icons.error_outline,
                size: 28.0,
                color: Colors.white,
              ),
              duration: Duration(seconds: 3),
              backgroundColor: Colors.red,
              borderRadius: 8,
              margin: EdgeInsets.all(8),
            )..show(context);
          }

          if(state is AuthenticationAuthenticated){
            LoadingDialog.hide(context);
            Navigator.of(context).pushReplacementNamed('main',arguments:MainScreenArguments(state.healthNetRepository, state.email));
            BlocProvider.of<AuthenticationBloc>(context).close();
          }
        },

        builder: (context, state) {
          if(state is AuthenticationUnauthenticated)
          {
            return SingleChildScrollView(
              child:Column(
                children: <Widget>[
                  HealthNetLogo(
                    padding: EdgeInsets.only(top:32),
                    height: 150,
                    width: 150,
                  ),

                  Padding(
                    padding: EdgeInsets.all(8).copyWith(bottom:32),
                    child: Text("HEALTH-NET",style:Theme.of(context).textTheme.display1.copyWith(color:Theme.of(context).backgroundColor, fontWeight: FontWeight.bold),),
                  ),

                  BlocProvider.value(
                    value: BlocProvider.of<AuthenticationBloc>(context),
                    child: LoginForm(),
                    )
              ],
              )
            );
          }
          return Container(height: 0.0,width: 0.0,);
        },
      ),
    );
}
}
