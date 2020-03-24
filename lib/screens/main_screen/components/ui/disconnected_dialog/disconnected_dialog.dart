import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_net_frontend/blocs/authentication/authentication_bloc.dart';

class DisconnectedDialog {
  final BuildContext context;

  DisconnectedDialog(this.context);

  void show() {
    WidgetsBinding.instance.addPostFrameCallback((duration) async => {
         await showDialog(
              context: context,
              barrierDismissible: false,
              child: WillPopScope(
                  child: AlertDialog(
                    title: Column(
                      children: <Widget>[
                        Icon(Icons.sentiment_dissatisfied),
                        Text("You have been disconnected")
                      ],
                    ),

                    content:SingleChildScrollView(
                      child:Flexible(
                        child:Text("Server refused your connection parameters, probably due to an expired authentication. Try connecting again.")
                        ),
                    ),

                    actions: <Widget>[
                      IconButton(icon: Icon(Icons.check), onPressed:(){
                        Navigator.of(context).pop();
                      })
                    ],
                  ),
                  onWillPop: () async => false))
        });
  }
}
