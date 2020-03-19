import 'dart:convert';
import 'dart:io';
import 'package:health_net_frontend/services/components/API_interfaces.dart';
import 'package:http/http.dart' as http;

import 'package:health_net_frontend/models/user.dart';

class UsersManagementHandler {
  ///Retrieve the users list from Health-Net API.
  static Future<http.Response> fetchUsersList(String authToken) async {
    return await http.get(APIInterfaces.geUsersURl(),
        headers: {HttpHeaders.authorizationHeader: "Bearer " + authToken});
  }

  ///Asks for a user registration to Health-Net API.
  static Future<http.Response> registerNewUser(
      User user, String password, String authTok) async {
    Map<String, String> credentials = {
      "password": password,
      "email": user.email,
      "fullName": user.name
    };

    return await http.post(APIInterfaces.geUsersURl(),
        body: json.encode(credentials),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer " + authTok
        });
  }

  ///Asks Health-Net API to delete a specici.
  static Future<http.Response> deleteUser(User user, String authToken) async {
    //TODO
    throw UnimplementedError();
  }
}
