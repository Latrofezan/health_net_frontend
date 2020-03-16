import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'patients_event.dart';
part 'patients_state.dart';

class PatientsBloc extends Bloc<PatientsEvent, PatientsState> {
  @override
  PatientsState get initialState => PatientsInitial();

  @override
  Stream<PatientsState> mapEventToState(
    PatientsEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
