import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmailTextfield extends StatefulWidget {
  final TextEditingController _controller;

  const EmailTextfield(this._controller, {Key key}) : super(key: key);

  @override
  State<EmailTextfield> createState() => _EmailTextfieldState();
}

class _EmailTextfieldState extends State<EmailTextfield> {
  bool _error;

  @override
  void initState() {
    super.initState();
    _error = false;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: widget._controller,
      validator: (value) {
        //RFC2822 Validation
        String mailRegEx =
            "[a-z0-9!#\$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#\$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";
        if (!RegExp(mailRegEx).hasMatch(value)) {
          setState(() {
            _error = true;
          });
          return 'insert a valid email';
        }
        setState(() {
              _error = false;
            });
        return null;
      },
      decoration: InputDecoration(
        labelText: 'email',
        prefixIcon: Icon(Icons.account_circle, size: 30,color: (_error)?Theme.of(context).errorColor:null,)
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }
}
