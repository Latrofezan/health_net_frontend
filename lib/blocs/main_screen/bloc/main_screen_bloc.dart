import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:health_net_frontend/repository/components/devices_repository.dart';
import 'package:health_net_frontend/repository/components/patients_repository.dart';
import 'package:health_net_frontend/repository/components/users_repository.dart';

import 'package:health_net_frontend/repository/repository.dart';

part 'main_screen_event.dart';
part 'main_screen_state.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  final HealthNetRepository _repository;

  MainScreenBloc(this._repository);

  @override
  MainScreenState get initialState => PatientsScreenSelected(_repository.patients,_repository.devices);

  @override
  Stream<MainScreenState> mapEventToState(
    MainScreenEvent event,
  ) async* {
    if(event is PageSelected)
    {
      switch(event.index){
        case 0:{
          yield PatientsScreenSelected(_repository.patients,_repository.devices);
        }break;

        case 1:{
          yield UsersScreenSelected(_repository.users);
        }break;
      }
    }
  }
}
