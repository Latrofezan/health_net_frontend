import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:health_net_frontend/models/device.dart';
import 'package:health_net_frontend/models/patient.dart';
import 'package:health_net_frontend/services/devices_management_API_handler.dart';

class DevicesRepository {
  final Map<Patient, List<Device>> _devices;
  final String authToken;

  DevicesRepository._private(this.authToken, this._devices);

  factory DevicesRepository(String authToken) {
    return DevicesRepository._private(authToken, Map<Patient, List<Device>>());
  }

  ///returns a [Map<Patient,int>] containing the patients which devices couldn't be fetched and the related errorCodes.
  Future<Map<Patient, int>> fetch(List<Patient> patients) async {
    Map<Patient, int> result = new Map<Patient, int>();
    http.Response response;
    await Future.forEach(patients, (patient) async {
      response =
          await DevicesAPInHandler.getDevicesByPatientID(patient.id, authToken);
      if (response.statusCode >= 200 && response.statusCode < 400) {
        var devicesJson = jsonDecode(response.body) as List;
        _devices[patient] =
            devicesJson.map((device) => Device.fromJSon(device)).toList();
      } else
        result.putIfAbsent(patient, () => response.statusCode);
    });
    return result;
  }

  ///returns the http response's statuscode if it's not between 200 and 400.
  ///returns a List<[Device]> if devices are obtained for the given [patient].
  Future<dynamic> get(Patient patient) async {
    if (_devices[patient] != null && _devices[patient].isNotEmpty)
      return _devices[patient];
    else {
      var response =
          await DevicesAPInHandler.getDevicesByPatientID(patient.id, authToken);
      if (response.statusCode >= 200 && response.statusCode < 400) {
        var devicesJson = jsonDecode(response.body) as List;
        _devices[patient] =
            devicesJson.map((device) => Device.fromJSon(device)).toList();
        return _devices[patient];
      } else
        return response.statusCode;
    }
  }

  Map<Patient, List<Device>> getAll() {
    return _devices;
  }

  bool isEmpty() {
    return _devices.isEmpty;
  }

  void clear(){
    _devices.clear();
  }
}
