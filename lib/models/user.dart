import 'dart:convert';
import 'package:equatable/equatable.dart';

class User extends Equatable{
  final String id;
  final String name;
  final String email;

  User( this.id, this.name, this.email);

    factory User.fromJSon(dynamic json) =>
    User(json['id'] as String, json['fullName'] as String, json['email']);

    String toJSon(){
      return jsonEncode(
        {
          'id':id,
          'fullName':name,
          'email':email
        }
      );
    }

  @override
  List<Object> get props =>[id,name,email];
}