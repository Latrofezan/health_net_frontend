import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'devices_event.dart';
part 'devices_state.dart';

class DevicesBloc extends Bloc<DevicesEvent, DevicesState> {
  @override
  DevicesState get initialState => DevicesInitial();

  @override
  Stream<DevicesState> mapEventToState(
    DevicesEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
