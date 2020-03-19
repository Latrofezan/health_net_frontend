import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HealthNetLogo extends StatelessWidget{
  final double height;
  final double width;
  final EdgeInsets padding;

  const HealthNetLogo({Key key, this.height, this.width, this.padding}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child:Container(
      color: Colors.transparent,
      height: height??100,
      width: width??100,
      child: Image.asset('assets/logo/logo.png',height: height,width: width,),
    ));
  }

}