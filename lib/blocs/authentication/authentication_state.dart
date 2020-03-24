part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}
///default state of authentication bloc
class AuthenticationUninitialized extends AuthenticationState {
  @override
  List<Object> get props => [];
}
///used when no valid authenticationToken 
class AuthenticationUnauthenticated extends AuthenticationState {
  final String lastEmail;

  AuthenticationUnauthenticated(this.lastEmail);

  @override
  List<Object> get props => [];
}

class AuthenticationAuthenticated extends AuthenticationState{
  final String email;
  final HealthNetRepository healthNetRepository;

  AuthenticationAuthenticated(this.healthNetRepository, this.email);

  @override
  List<Object> get props => [];
  
}

class AuthenticationFailed extends AuthenticationState{
  final int statusCode;
  final String errorMessage;

  AuthenticationFailed(this.statusCode, this.errorMessage);

  @override
  List<Object> get props =>[statusCode];
  
}

class AuthenticationValidating extends AuthenticationState {
  @override
  List<Object> get props => [];
}
