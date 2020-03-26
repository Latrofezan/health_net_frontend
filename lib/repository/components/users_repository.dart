import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:health_net_frontend/models/user.dart';
import 'package:health_net_frontend/services/users_management_API_handler.dart';

class UsersRepository{
  final List<User> _users;
  final String authToken;

  UsersRepository._private(this.authToken, this._users);

  factory UsersRepository(String authToken){
    return UsersRepository._private(authToken,List<User>());
  }

  Future<int> add(User user, String password) async{
    int result=0;
    try{
      var response=await UsersManagementHandler.registerNewUser(user, password, authToken);
       result=response.statusCode;
          if(response.statusCode>=200&&response.statusCode<400)
              _users.add(user);
    }on SocketException catch(excep){return excep.osError.errorCode;}
    return result;
  }

  Future<int> fetch() async{
    int result =0;
    try{
    var response=await UsersManagementHandler.fetchUsersList(authToken);
    result=response.statusCode;
      if(response.statusCode>=200&&response.statusCode<400)
        {
        var usersJson = jsonDecode(response.body) as List;
        var fetched=usersJson.map((user) => User.fromJSon(user)).toList();
        _users.clear();
        _users.addAll(fetched);
        }
    }on SocketException catch(excep){return excep.osError.errorCode;}
    return result;
  }

  List<User> getAll(){
    return _users;
  }

  User get(String email) {
    return _users.firstWhere((user)=>user.email==email,orElse:()=>null);
  }

  Future<bool> remove(User user) {
    // TODO: implement remove
    return null;
  }

  bool isEmpty(){
    return _users.isEmpty;
  }
}
