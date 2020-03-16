import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'users_management_event.dart';
part 'users_management_state.dart';

class UsersManagementBloc extends Bloc<UsersManagementEvent, UsersManagementState> {
  @override
  UsersManagementState get initialState => UsersManagementInitial();

  @override
  Stream<UsersManagementState> mapEventToState(
    UsersManagementEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
