import 'package:flutter/material.dart';
import 'package:health_net_frontend/repository/components/users_repository.dart';
import 'package:health_net_frontend/screens/main_screen/components/consumer/components/users/components/flush_bars/error_flush_bar.dart';
import 'package:health_net_frontend/screens/main_screen/components/consumer/components/users/components/flush_bars/success_flush_bar.dart';

import 'users_registration_data.dart';
import 'users_registration_form.dart';

class UserRegistrationDialog {
  final BuildContext _context;

  UserRegistrationDialog(this._context);

  Future<void> show(UsersRepository repository) async {
    UsersRegistrationData result;
    result = await showDialog(
        context: _context,
        child: Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            height: 530,
            width: 350,
            decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(32),
                border: Border.all(
                    color: Theme.of(_context).primaryColor, width: 3)),
            child: Column(children: <Widget>[
              Container(
                width: double.infinity,
                height: 50,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  color: Theme.of(_context).primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text("User Registration",
                      style: Theme.of(_context).textTheme.title),
                ),
              ),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(8),
                      child: UserRegistrationForm()))
            ]),
          ),
        ));
      if(result!=null){
        int statusCode = await repository.add(result.user, result.password);
      }
  }

    _usersResultEvaluation(BuildContext context, UsersRegistrationData tentative, int statusCode, UsersRepository repository) async {
      if(statusCode >= 200 && statusCode < 400){
          SuccessFlushBar(tentative.user, context).show();
      }
      else
      {
        UsersRegistrationData retryUser = await ErrorFlushBar(tentative, context, statusCode).show();
        if(retryUser!=null)
        {
          int retryResult = await repository.add(tentative.user,tentative.password);
          await _usersResultEvaluation(context, retryUser, retryResult, repository);
        }
      }
  }
}
