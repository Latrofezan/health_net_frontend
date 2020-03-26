part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();
}

class UsersFetchingRequired extends UsersEvent{
  final bool refresh;

  UsersFetchingRequired(this.refresh);
  @override
  List<Object> get props => null;
  
}