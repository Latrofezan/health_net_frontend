import 'dart:convert';

import 'package:equatable/equatable.dart';

class Patient extends Equatable{
  final String id;
  final String fullName;

  Patient(this.id, this.fullName);

  factory Patient.fromJSon(dynamic json) =>
    Patient(json['id'] as String, json['fullName'] as String);

    String toJSon(){
      return jsonEncode(
        {
          'id':id,
          'fullName':fullName,
        }
      );
    }

  @override
  List<Object> get props =>[id, fullName];

}