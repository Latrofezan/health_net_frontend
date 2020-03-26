import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordTextField(this.controller,{Key key}) : super(key: key);
  @override
  State<PasswordTextField> createState() => _PasswordVisibleElementState();
}

class _PasswordVisibleElementState extends State<PasswordTextField> {
  bool _passwordVisible;
  bool _error;
  @override
  void initState() {
    _passwordVisible = false;
    _error=false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: !_passwordVisible,

      controller: widget.controller,
      validator: (value) {
        if (value.isEmpty) {
            setState(() {
              _error = true;
            });
          return 'insert a password';
        }
        setState(() {
              _error = false;
            });
        return null;
      },

      decoration: InputDecoration(
        labelText: 'password',
        prefixIcon: Icon(Icons.lock, size: 30,color: (_error)?Theme.of(context).errorColor:null,),
        suffixIcon: GestureDetector(
          onLongPress: () {
            setState(() {
              _passwordVisible = true;
            });
          },
          onLongPressUp: () {
            setState(() {
              _passwordVisible = false;
            });
          },
          child:
              Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off,color: (_error)?Theme.of(context).errorColor:null,),
        ),
      ).applyDefaults(Theme.of(context).inputDecorationTheme), //,
    );
  }
}
