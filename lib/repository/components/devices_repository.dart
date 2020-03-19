import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:health_net_frontend/models/device.dart';
import 'package:health_net_frontend/models/patient.dart';
import 'package:health_net_frontend/services/devices_management_API_handler.dart';

class DevicesRepository{
  final Map<Patient,List<Device>> _devices;
  final String authToken;

  DevicesRepository._private(this.authToken, this._devices);

  factory DevicesRepository(String authToken){
    return DevicesRepository._private(authToken,Map<Patient,List<Device>>());
  }

  Future<Map<Patient, int>> fetch(List<Patient> patients)async{
    Map<Patient,int> result;
    patients.forEach((patient)=>{
      DevicesAPInHandler.getDevicesByPatientID(patient.id, authToken).then(
        (http.Response response){
          result[patient]=response.statusCode;
          if(response.statusCode>=200&&response.statusCode<400)
          {
            var devicesJson = jsonDecode(response.body) as List;
            _devices[patient]=devicesJson.map((device) => Device.fromJSon(device)).toList();
          }
        }
      )
    });
    return result;
  }

  List<Device> get(Patient patient){
    return _devices[patient];
  }
}