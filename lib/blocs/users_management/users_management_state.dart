part of 'users_management_bloc.dart';

abstract class UsersManagementState extends Equatable {
  const UsersManagementState();
}

class UsersManagementInitial extends UsersManagementState {
  @override
  List<Object> get props => [];
}
