import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_net_frontend/models/user.dart';

class UserCard extends StatelessWidget {
  final User user;

  const UserCard(this.user, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical:8),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          border:
              Border.all(color: Theme.of(context).backgroundColor, width: 2)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(8),
              child: Icon(Icons.person,
                  color: Theme.of(context).backgroundColor, size: 30)),
          Expanded(
              child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Name:", style: Theme.of(context).textTheme.body2),
                    Text(user.name,
                        style: Theme.of(context)
                            .textTheme
                            .body1
                            .copyWith(fontSize: 12)),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Email:", style: Theme.of(context).textTheme.body2),
                    Text(user.email,
                        style: Theme.of(context)
                            .textTheme
                            .body1
                            .copyWith(fontSize: 12)),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Id:", style: Theme.of(context).textTheme.body2),
                    Text(user.id,
                        style: Theme.of(context)
                            .textTheme
                            .body1
                            .copyWith(fontSize: 11)),
                  ],
                ),
              ),
            ],
          )
          ),
          Padding(
            padding: EdgeInsets.all(6).copyWith(right:10),
            child:IconButton(icon: Icon(Icons.delete,size:25,color:Theme.of(context).accentColor), onPressed: null)
            )
         
        ],
      ),
    );
  }
}
