import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:health_net_frontend/models/patient.dart';
import 'package:health_net_frontend/services/patients_management_API_handler.dart';

class PatientsRepository {
  final List<Patient> _patients;
  final String authToken;

  PatientsRepository._private(this.authToken, this._patients);

  factory PatientsRepository(String authToken) {
    return PatientsRepository._private(authToken, List<Patient>());
  }

  Future<int> add(Patient patient) async {
    int result = 0;
    try {
      var response =
          await PatientsAPIHandler.registerPatient(patient, authToken);
      result = response.statusCode;
      if (response.statusCode >= 200 && response.statusCode < 400) {
        _patients.add(patient);
        _sort();
      }
    } on SocketException catch (excep) {
      return excep.osError.errorCode;
    }
    return result;
  }

  ///fetch all patients from HealthNetAPI.
  ///
  ///return response's status code
  Future<int> fetch() async {
    var patients = List<Patient>();
    http.Response response;
    try {
      response = await PatientsAPIHandler.getAllPatients(authToken);
    } on SocketException catch (excep) {
      return excep.osError.errorCode;
    }
    if (response.statusCode >= 200 && response.statusCode < 400) {
      var patientsJson = jsonDecode(response.body) as List;
      patients =
          patientsJson.map((patient) => Patient.fromJSon(patient)).toList();
    }
    _patients.clear();
    _patients.addAll(patients);
    _sort();

    return response.statusCode;
  }

  Patient get(String id) {
    return _patients.firstWhere((patient) => patient.id == id,
        orElse: () => null);
  }

  List<Patient> getAll() {
    return _patients;
  }

  Future<bool> remove(Patient element) {
    // TODO: implement remove
    return null;
  }

  bool isEmpty() {
    return _patients.isEmpty;
  }

  void _sort() {
    _patients.sort((a, b) {
      int result = a.fullName.toLowerCase().compareTo(b.fullName.toLowerCase());
      if (result != 0)
        return result;
      else
        return a.id.compareTo(b.id);
    });
  }
}
