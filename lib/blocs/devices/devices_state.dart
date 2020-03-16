part of 'devices_bloc.dart';

abstract class DevicesState extends Equatable {
  const DevicesState();
}

class DevicesInitial extends DevicesState {
  @override
  List<Object> get props => [];
}
