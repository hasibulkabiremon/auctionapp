import 'package:auction/auth/authservice.dart';
import 'package:auction/pages/loginpage.dart';
import 'package:auction/pages/viewproduct.dart';
import 'package:flutter/material.dart';

class LauncherPage extends StatelessWidget {
  static const String routeName = '/';
  const LauncherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, (){
      if(AuthService.currentUser != null){
        Navigator.pushReplacementNamed(context, ViewProductPage.routeName);
      }else{
        Navigator.pushReplacementNamed(context, LoginPage.routeName);
      }
    });
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
