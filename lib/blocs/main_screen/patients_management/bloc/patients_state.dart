part of 'patients_bloc.dart';

abstract class PatientsState extends Equatable {
  const PatientsState();
}

class PatientsUninitialized extends PatientsState {
  @override
  List<Object> get props => [];
}

class PatientsFetching extends PatientsState{

  PatientsFetching();
  @override
  List<Object> get props => [];
  
}

class PatientsFetchingFailed extends PatientsState{
  final int patientsFetchingstatusCode;


  PatientsFetchingFailed(this.patientsFetchingstatusCode);
  @override
  List<Object> get props => [patientsFetchingstatusCode];
}

class PatientsFetchingSuccess extends PatientsState{
  final List<Patient> patients;
  final TextEditingController searchBarController;
  
  PatientsFetchingSuccess(this.patients, this.searchBarController);
  @override
  // TODO: implement props
  List<Object> get props => [patients,searchBarController];
  
}