import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PatientsAppBar extends StatefulWidget {
  final TextEditingController searchBarController;
  final double height;
  final double width;

  const PatientsAppBar(
      {Key key, this.searchBarController, this.height, this.width})
      : super(key: key);
  @override
  State<PatientsAppBar> createState() => _PatientsAppBarState();
}

class _PatientsAppBarState extends State<PatientsAppBar> {
  @override
  Widget build(BuildContext context) {
    //TODO
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top:30),
            child: Text("Patients", style: Theme.of(context).textTheme.title),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: TextField(
              controller: widget.searchBarController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, size: 20),
              ),
            ),
          )
        ],
      ),
    );
  }
}
