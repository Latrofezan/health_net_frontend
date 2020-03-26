import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:health_net_frontend/models/user.dart';
import 'package:health_net_frontend/repository/components/users_repository.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final UsersRepository usersRepository;
  final String authMail;
  UsersBloc(this.usersRepository, this.authMail);

  @override
  UsersState get initialState => UsersUninitialized();

  @override
  Stream<UsersState> mapEventToState(
    UsersEvent event,
  ) async* {
    if(event is UsersFetchingRequired){
      int statuscode=200;
      yield UsersFetching();
      if(event.refresh||usersRepository.isEmpty())
        {
          statuscode = await usersRepository.fetch();
        }
      if(statuscode>=200&&statuscode<400)
          {
          var list = usersRepository.getAll().where((user)=>user.email!=authMail).toList();
          yield UsersFetchingSuccess(list,usersRepository.get(authMail));
          }
      else
          yield UsersFetchingFailed(statuscode);
    }
  }
}
