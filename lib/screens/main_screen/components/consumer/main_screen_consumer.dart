import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:health_net_frontend/screens/main_screen/components/logout_dialog/logout_dialog.dart';
class MainScreenConsumer extends StatefulWidget{
  @override
  State<MainScreenConsumer> createState()=>_MainScreenConsumerState();
  
  }
  
  class _MainScreenConsumerState extends State<MainScreenConsumer>{
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Center(child: Text("Next Step"),),
      onWillPop:()async{
        var result= await LogoutDialog.show(context);
        FlutterSecureStorage secureStorage= FlutterSecureStorage();
        if(result){
          await secureStorage.delete(key: 'authToken');
          await secureStorage.delete(key: 'authMail');
          Navigator.of(context).pushReplacementNamed('login');
        }
        return false;
      });
  }
    
}