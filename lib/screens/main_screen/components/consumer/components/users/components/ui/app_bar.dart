import 'package:flutter/material.dart';
import 'package:health_net_frontend/models/user.dart';

class UsersAppBar extends StatelessWidget {
  final User actualUser;
  final double height;
  final double width;

  const UsersAppBar(this.actualUser, {Key key, this.height, this.width})
      : super(key: key);

  Widget build(BuildContext context) {
    //TODO
    return Container(
        height: height,
        width: width,
        padding: EdgeInsets.symmetric(horizontal:8,vertical:10),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24))),
        child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: Text("Welcome", style: Theme.of(context).textTheme.title),
          ),
          Padding(
            padding: EdgeInsets.all(4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Name: ", style: Theme.of(context).textTheme.subhead),
                Text(actualUser.name,
                    style: Theme.of(context).textTheme.subhead),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Email: ", style: Theme.of(context).textTheme.subhead),
                Text(actualUser.email,
                    style: Theme.of(context).textTheme.subhead),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Id: ", style: Theme.of(context).textTheme.subhead),
                Text(actualUser.id, style: Theme.of(context).textTheme.body1),
              ],
            ),
          )
        ]));
  }
}
