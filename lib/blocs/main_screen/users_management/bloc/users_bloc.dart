import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:health_net_frontend/repository/components/users_repository.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UsersRepository usersRepository;

  UsersBloc(this.usersRepository);
  @override
  UsersState get initialState => UsersInitial();

  @override
  Stream<UsersState> mapEventToState(
    UsersEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
