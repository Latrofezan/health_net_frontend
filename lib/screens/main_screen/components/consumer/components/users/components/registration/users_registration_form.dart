import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_net_frontend/models/user.dart';
import 'package:health_net_frontend/screens/login_screen/components/ui/login_form/components/email_textfield.dart';
import 'package:health_net_frontend/screens/login_screen/components/ui/login_form/components/password_textfield.dart';
import 'package:uuid/uuid.dart';

import 'users_registration_data.dart';

class UserRegistrationForm extends StatefulWidget {
  @override
  State<UserRegistrationForm> createState() => _UserRegistrationFormState();
}

class _UserRegistrationFormState extends State<UserRegistrationForm> {
  var _nameController = TextEditingController();
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var _passwordValidationController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  bool _matchError;
  bool _nameEmpty;

  @override
  void initState() {
    _nameEmpty = false;
    _matchError = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: TextFormField(
                  obscureText: true,

                  controller: _nameController,
                  validator: (value) {
                    if (value.isEmpty) {
                      setState(() {
                        _nameEmpty = true;
                      });
                      return 'insert a name';
                    }
                    setState(() {
                      _nameEmpty = false;
                    });
                    return null;
                  },

                  decoration: InputDecoration(
                    labelText: 'name',
                    prefixIcon: Icon(
                      Icons.subject,
                      size: 30,
                      color: (_nameEmpty) ? Theme.of(context).errorColor : null,
                    ),
                  ).applyDefaults(Theme.of(context).inputDecorationTheme), //,
                )),

            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: EmailTextfield(_emailController),
            ),

            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: PasswordTextField(_passwordController),
            ),

            Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: TextFormField(
                  obscureText: true,

                  controller: _passwordValidationController,
                  validator: (value) {
                    if (value != _passwordController.text) {
                      setState(() {
                        _matchError = true;
                      });
                      return 'passwords doesn\'t match';
                    }
                    setState(() {
                      _matchError = false;
                    });
                    return null;
                  },

                  decoration: InputDecoration(
                    labelText: 'validate password',
                    prefixIcon: Icon(
                      Icons.lock,
                      size: 30,
                      color:
                          (_matchError) ? Theme.of(context).errorColor : null,
                    ),
                  ).applyDefaults(Theme.of(context).inputDecorationTheme), //,
                )),

            //submit button
            FlatButton(
                color: Theme.of(context).buttonColor,
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 40, right: 40),
                child: Text(
                  'Register',
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Navigator.of(context).pop(UsersRegistrationData(User(Uuid().v4(),_nameController.text,_emailController.text),_passwordController.text));
                  }
                })
          ],
        ),
      ),
    );
  }
}
