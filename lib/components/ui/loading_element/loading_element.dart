import 'package:flutter/material.dart';

class LoadingElement extends StatelessWidget {
  final double radius;

  const LoadingElement({Key key, this.radius,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
          child: SizedBox(
            height: radius??60,
            width: radius??60,
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
              strokeWidth: 5,
            ),
          ),
      );
  }
}
