import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_net_frontend/blocs/authentication/authentication_bloc.dart';
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
        stops: [0.2,1.0],
        begin: FractionalOffset.topCenter,
        end: FractionalOffset.bottomCenter,
      )),
      child: BlocConsumer<AuthenticationBloc, AuthenticationState>(

        listener: (context, state) {
          if (state is AuthenticationFailed) {
            BlocProvider.of<AuthenticationBloc>(context).add(AppStarted());
            Flushbar(
              title: (state.statusCode==401)?null:"Error "+state.statusCode.toString(),
              message:(state.statusCode==401)?"Invalid credentials. Please, try again":state.errorMessage,
              icon: Icon(
                Icons.error_outline,
                size: 28.0,
                color: Colors.white,
              ),
              duration: Duration(seconds: 5),
              backgroundColor: Theme.of(context).errorColor,
              borderRadius: 8,
              margin: EdgeInsets.all(8),
            )..show(context);
          }

          if(state is AuthenticationAuthenticated){
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
                    height: 200,
                    width: 200,
                  ),

                  Padding(
                    padding: EdgeInsets.all(8).copyWith(bottom:32),
                    child: Text("HEALTH-NET",style:Theme.of(context).textTheme.display2.copyWith(color:Theme.of(context).backgroundColor, fontWeight: FontWeight.bold),),
                  ),

                  BlocProvider.value(
                    value: BlocProvider.of<AuthenticationBloc>(context),
                    child: LoginForm(height: 370,width: 340,),
                    )
              ],
              )
            );
          }

          /*if(state is AuthenticationValidating){
            return LoadingElement();
          }*/
          return LoadingElement();;
        },
      ),
    );
}
}
