import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:health_net_frontend/services/components/API_interfaces.dart';
import 'package:health_net_frontend/services/components/API_exception.dart';

class AuthenticationHandler {
  ///Asks the authentication microservice to provide a valid token for the given credentials.
  ///
  ///Throws a [APIException] if the http response doesn't contain the expected datas.
  static Future<String> sendAuthenticationRequest(
      String email, String password) async {
    Map<String, String> credentials = {"email": email, "password": password};

    return await http.post("https://" + APIInterfaces.getAuthenticationURl(),
        body: json.encode(credentials),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json"
        }).then((http.Response response) {
      if (response.statusCode < 200 ||
          response.statusCode >= 400 ||
          json == null) {
        print(json.encode(credentials));
        throw new APIException(response.statusCode);
      }
      Map<String, dynamic> res = json.decode(response.body);

      return res['access_token'];
    });
  }
}
