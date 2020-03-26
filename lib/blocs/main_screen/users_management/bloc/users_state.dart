part of 'users_bloc.dart';

abstract class UsersState extends Equatable {
  const UsersState();
}

class UsersUninitialized extends UsersState {
  @override
  List<Object> get props => [];
}

class UsersFetching extends UsersState {
  @override
  List<Object> get props => [];
}

class UsersFetchingFailed extends UsersState {
  final int statusCode;

  UsersFetchingFailed(this.statusCode);
  @override
  List<Object> get props => [];
}

class UsersFetchingSuccess extends UsersState {
  final List<User> users;
  final User actualUser;
  UsersFetchingSuccess(this.users, this.actualUser);
  @override
  List<Object> get props => [users];
}