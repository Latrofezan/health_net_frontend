import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:health_net_frontend/repository/repository.dart';
import 'package:health_net_frontend/services/authentication_API_handler.dart';
import 'package:health_net_frontend/services/components/API_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    FlutterSecureStorage secureStorage = new FlutterSecureStorage();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String lastEmail = sharedPreferences.getString('lastEmail') ?? "";
    if (event is AppStarted) {
      yield AuthenticationValidating();
      String existingToken = await secureStorage.read(key: 'authToken');
      if (["", null].contains(existingToken)) {
        yield AuthenticationUnauthenticated(lastEmail);
      } else {
        String authenticationMail = await secureStorage.read(key: 'authMail');
        yield AuthenticationAuthenticated(HealthNetRepository(existingToken),authenticationMail);
      }
    }

    if (event is LoginRequest) {
      yield AuthenticationValidating();
      try {
        final String authToken =
            await AuthenticationHandler.sendAuthenticationRequest(
                event.email, event.password);
        //if rememberMe is active, the email address is saved as Shared Preference.
        if (event.rememberMe)
          await sharedPreferences.setString('lastEmail', event.email);
        //saving the token in keychain/keystore
        await secureStorage.write(key: 'authToken', value:"Bearer "+authToken);
        //saving the email in keychain/keystore
        await secureStorage.write(key: 'authMail', value: event.email);
        yield AuthenticationAuthenticated(
            new HealthNetRepository("Bearer " + authToken),event.email);
      } on APIException catch (excep) {
        yield AuthenticationFailed(excep.statusCode, excep.toString());
      } on SocketException catch (excep) {
        yield AuthenticationFailed(
            excep.osError.errorCode, excep.message ?? excep.osError.message);
      }
    }

    /*if (event is LogoutRequest) {
      await secureStorage.delete(key: 'authToken');
      if(event.unauthorized)
      yield AuthenticationUnauthorized();
      else
      yield AuthenticationUnauthenticated(lastEmail);
    }*/
  }
}
