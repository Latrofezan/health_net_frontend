import 'dart:async';
import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_net_frontend/blocs/main_screen/patients_management/bloc/patients_bloc.dart';
import 'package:health_net_frontend/models/patient.dart';
import 'package:health_net_frontend/screens/main_screen/components/consumer/components/patients/components/ui/patient_card/patient_card.dart';

class PatientsCardList extends StatefulWidget {
  final List<Patient> patients;
  final TextEditingController filter;

  const PatientsCardList(this.filter, this.patients, {Key key})
      : super(key: key);
  @override
  State<PatientsCardList> createState() => _PatientsCardListState();
}

class _PatientsCardListState extends State<PatientsCardList> {
  Map<Patient, Widget> _cards, _filtered;
  String _searchText;

  @override
  void initState() {
    _searchText = "";
    _cards = Map.fromEntries(widget.patients.map((patient) => MapEntry(
        patient,
        BlocProvider.value(
          value: BlocProvider.of<PatientsBloc>(context),
          child: PatientCard(patient),
        ))));
    _filtered = _cards;
    widget.filter.addListener(() => Debouncer(milliseconds: 500).run(() {
          if (widget.filter.text != _searchText) {
            setState(() {
              _searchText = widget.filter.text;
            });
            _cardFilter();
          }
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: CustomScrollView(slivers: <Widget>[
          SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
            return _filtered.values.elementAt(index);
          }, childCount: _filtered.length))
        ]),
        onRefresh: () async => BlocProvider.of<PatientsBloc>(context)
            .add(PatientsFetchingRequired(true)));
  }

  void _cardFilter() {
    List<Patient> nameFilter;
    nameFilter = widget.patients
        .where((patient) =>
            patient.fullName.toLowerCase().contains(_searchText.toLowerCase()))
        .toList();
    setState(() {
      _filtered = Map.fromEntries(
          _cards.entries.where((entry) => nameFilter.contains(entry.key)));
    });
  }
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
