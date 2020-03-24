part of 'patients_bloc.dart';

abstract class PatientsEvent extends Equatable {
  const PatientsEvent();
}

class PatientsFetchingRequired  extends PatientsEvent{
  final bool refresh;
  PatientsFetchingRequired(this.refresh);
  @override
  // TODO: implement props
  List<Object> get props => null;
  
}