import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:health_net_frontend/services/components/API_interfaces.dart';
import 'package:health_net_frontend/services/components/API_exception.dart';

import 'package:health_net_frontend/models/patient.dart';

class PatientsAPIHandler {
  ///Asks for patients' details to HealthNet API.
  static Future<http.Response> getAllPatients(String authToken) async {
    return await http.get(APIInterfaces.getPatientsURl(),
        headers: {HttpHeaders.authorizationHeader: authToken});
  }

  ///Asks for a specific patient details to HEalth-Net API.
  static Future<http.Response> getPatientById(String id, String authToken) async {
    return await http.get(APIInterfaces.getPatientsURl() + "/" + id,
        headers: {HttpHeaders.authorizationHeader: authToken});
  }

  /// Asks the patient microservice to store a new patient's anagraphic details.
  static Future<http.Response> registerPatient(
      Patient myPatient, String authToken) async {
    await http.post(APIInterfaces.getPatientsURl(),
        body: myPatient.toJSon(),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer " + authToken
        });
  }
}
