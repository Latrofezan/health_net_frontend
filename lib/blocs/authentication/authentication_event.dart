part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class AppStarted extends AuthenticationEvent{
  @override
  List<Object> get props => null;
  
}

class LoginRequest extends AuthenticationEvent{
  final String email;
  final String password;
  final bool rememberMe;

  LoginRequest(this.email, this.password, this.rememberMe);

  @override
  List<Object> get props =>[email];
}