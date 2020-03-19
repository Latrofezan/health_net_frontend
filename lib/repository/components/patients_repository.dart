import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:health_net_frontend/models/patient.dart';
import 'package:health_net_frontend/services/patients_management_API_handler.dart';

class PatientsRepository{
  final List<Patient> _patients;
  final String authToken;

  PatientsRepository._private(this.authToken, this._patients);

  factory PatientsRepository(String authToken){
    return PatientsRepository._private(authToken,List<Patient>());
  }
  
  
  Future<bool> add(Patient patient) {
    // TODO: implement add
    return null;
  }

  ///fetch all patients from HealthNetAPI.
  /// 
  ///return response's status code
  Future<int> fetch() async {
    int result=0;
     try{
    _patients.addAll(
      await PatientsAPIHandler.getAllPatients(authToken).then(
      (http.Response response){
        result=response.statusCode;
        if(response.statusCode>=200&&response.statusCode<400)
        {
        var patientsJson = jsonDecode(response.body) as List;
        return patientsJson.map((patient) => Patient.fromJSon(patient)).toList();
        }
      }
      )
    );
    }on SocketException catch(excep){
      return excep.osError.errorCode;
    }

    return result;
  }


  Patient get(String id){
    return _patients.firstWhere((patient)=>patient.id==id,orElse:()=>null);
  }

  List<Patient> getAll(){
    return _patients;
  }

  Future<bool> remove(Patient element) {
    // TODO: implement remove
    return null;
  }
}