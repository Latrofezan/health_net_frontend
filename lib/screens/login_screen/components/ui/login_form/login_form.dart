import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_net_frontend/blocs/authentication/authentication_bloc.dart';
import 'package:health_net_frontend/screens/login_screen/components/ui/login_form/components/email_textfield.dart';
import 'package:health_net_frontend/screens/login_screen/components/ui/login_form/components/password_textfield.dart';

class LoginForm extends StatefulWidget {
  final double height;
  final double width;
  final String initialMailBoxValue;

  const LoginForm({Key key, this.height, this.width, this.initialMailBoxValue})
      : super(key: key);
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _rememberMe;
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.initialMailBoxValue ?? "";
    _rememberMe = _emailController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: widget.height ?? 400,
        width: widget.width ?? 300,
        decoration: BoxDecoration(
          color: Colors.black38,
          border:
              Border.all(color: Theme.of(context).backgroundColor, width: 3),
          borderRadius: BorderRadius.circular(32),
        ),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //Email Input field
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: EmailTextfield(_emailController),
                ),
                //Password Input Field
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: PasswordTextField(_passwordController),
                ),

                CheckboxListTile(
                    activeColor: Theme.of(context).accentColor,
                    title: Text("remember me"),
                    value: _rememberMe,
                    onChanged: (bool newValue) {
                      setState(() {
                        _rememberMe = newValue;
                      });
                    }),
                //submit button
                FlatButton(
                    color: Theme.of(context).buttonColor,
                    padding: EdgeInsets.only(
                        top: 15, bottom: 15, left: 50, right: 50),
                    child: Text(
                      'LOGIN',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        BlocProvider.of<AuthenticationBloc>(context).add(
                            LoginRequest(_emailController.text,
                                _passwordController.text, _rememberMe));
                      }
                    })
              ],
            ),
          ),
        ));
  }
}
