import 'package:auction/auth/authservice.dart';
import 'package:auction/pages/launcherpage.dart';
import 'package:flutter/material.dart';

class ViewProductPage extends StatelessWidget {
  static const String routeName='/viewProduct';
  const ViewProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            AuthService.logout();
            Navigator.pushReplacementNamed(context, LauncherPage.routeName);
          }, icon: Icon(Icons.logout))
        ],
      ) ,
      body: Center(
        child: Text('View Product'),
      ),
    );
  }
}
