import 'package:flutter/material.dart';
import 'package:graduation_project/app_constants.dart';
import 'package:graduation_project/registration/Login/login.dart';
import 'package:graduation_project/student/student.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthContainrt extends StatefulWidget {
  static const String routeName='auth-screen';

  @override
  State<AuthContainrt> createState() => _AuthContainrtState();
}

class _AuthContainrtState extends State<AuthContainrt> {
  static String? token;
  bool initial =true;
  @override
  Widget build(BuildContext context) {
    if(initial)
    {
    SharedPreferences.getInstance().then((sharedPrefValue){
     setState(() {
       initial = false;
        token = sharedPrefValue.getString(AppConstants.KEY_ACCESS_TOKEN);
     });
    });
    return const Center(child: CircularProgressIndicator());
    }
    else{
      if(token == null){
        return Login();
      }
      else{
      return Student();
      }
    }
  }
}
