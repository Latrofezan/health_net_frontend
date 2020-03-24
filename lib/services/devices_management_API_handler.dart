import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:health_net_frontend/services/components/API_interfaces.dart';

class DevicesAPInHandler {
  ///
  static Future<http.Response> getDevicesByPatientID(
      String uuid, String authToken) async {
    return await http.get("https://"+APIInterfaces.getDevicesURl() + "?patientId=" + uuid,
        headers: {HttpHeaders.authorizationHeader:authToken});
  }
}
