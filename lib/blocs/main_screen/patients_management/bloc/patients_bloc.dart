import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:health_net_frontend/models/patient.dart';
import 'package:health_net_frontend/repository/components/devices_repository.dart';
import 'package:health_net_frontend/repository/components/patients_repository.dart';

part 'patients_event.dart';
part 'patients_state.dart';

class PatientsBloc extends Bloc<PatientsEvent, PatientsState> {
  final PatientsRepository patientsRepository;
  final DevicesRepository devicesRepository;

  PatientsBloc(this.patientsRepository, this.devicesRepository);
  @override
  PatientsState get initialState => PatientsUninitialized();

  @override
  Stream<PatientsState> mapEventToState(
    PatientsEvent event,
  ) async* {
    if (event is PatientsFetchingRequired) {
      int patientsFetchingResult;
      bool netRequired = true;
      if (!event.refresh) {
        if (!patientsRepository.isEmpty() && !devicesRepository.isEmpty()) {
          yield PatientsFetchingSuccess(patientsRepository.getAll(),TextEditingController());
          netRequired = false;
        }
      }
      if (netRequired) {
        yield PatientsFetching();
        patientsFetchingResult = await patientsRepository.fetch();
        devicesRepository.clear();
        if (patientsFetchingResult >= 200 && patientsFetchingResult < 400) {
          yield PatientsFetchingSuccess(patientsRepository.getAll(),
              TextEditingController());
        } else
          yield PatientsFetchingFailed(patientsFetchingResult);
      }
    }
  }
}
