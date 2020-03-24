import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogOutDialogContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        width: 250,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //crossAxisAlignment: CrossAxisAlignment.s,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child:
                    Text("Log Out", style: Theme.of(context).textTheme.title),
              ),
            ),
            Flexible(
                child:Text(
                "Are you sure?",
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
            padding: EdgeInsets.only(bottom:8),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                  color: Theme.of(context).buttonColor,
                  onPressed: (){Navigator.of(context).pop(true);},
                  child: Text(" Yes")),
                FlatButton(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                  color: Theme.of(context).buttonColor,
                  onPressed: (){Navigator.of(context).pop(false);},
                  child: Text(" No "))
            ],),)
            
          ],
        ));
  }
}
