import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_net_frontend/blocs/main_screen/bloc/main_screen_bloc.dart';

class HealthNetBottomAppBar extends StatefulWidget{
  @override
  State<HealthNetBottomAppBar> createState()=>_HealthNetBottomAppBarState();
  }
  
  class _HealthNetBottomAppBarState extends State<HealthNetBottomAppBar>{
  int _selectedIndex=0;
  @override
  Widget build(BuildContext context) {
    return   BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 8,
          clipBehavior: Clip.antiAlias,
          child: BottomNavigationBar(
            iconSize: 40,
              onTap:(index){
                  if(index!=_selectedIndex){
                    _updateIndex(index);
                    BlocProvider.of<MainScreenBloc>(context).add(PageSelected(index));
                  }
              },
              currentIndex: _selectedIndex,
              backgroundColor: Theme.of(context).primaryColor,
              selectedItemColor: Theme.of(context).accentColor,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.airline_seat_individual_suite), title: Text('Patients')),
                BottomNavigationBarItem(icon: Icon(Icons.person), title: Text('Users')),
              ]),
        );
  }

  _updateIndex(int index){
     setState(() {
      _selectedIndex = index;
    });
  }
}