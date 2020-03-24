part of 'main_screen_bloc.dart';

abstract class MainScreenState extends Equatable {
  const MainScreenState();
}

class PatientsScreenSelected extends MainScreenState {
  final PatientsRepository patientRepository;
  final DevicesRepository  devicesRepository;
  PatientsScreenSelected(this.patientRepository, this.devicesRepository);


  @override
  List<Object> get props => [];
}

class UsersScreenSelected extends MainScreenState {
  final UsersRepository usersRepository;

  UsersScreenSelected(this.usersRepository);
  @override
  List<Object> get props => [];
}