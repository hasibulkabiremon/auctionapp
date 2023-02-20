import 'package:auction/auth/authservice.dart';
import 'package:auction/model/usermodel.dart';
import 'package:auction/pages/launcherpage.dart';
import 'package:auction/provider/userprovider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late UserProvider userProvider;

  @override
  void didChangeDependencies() {
    userProvider = Provider.of<UserProvider>(context, listen: false);
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Auction'),),
      body: Center(
        child: TextButton.icon(
          onPressed: signInWithGoogle,
          icon: Icon(Icons.g_mobiledata),
          label: Text('Sign in with Google'),
        ),
      ),
    );
  }

  void signInWithGoogle() async {
    try {
      final credential = await AuthService.signInwithgmail();
      final userExist = await userProvider.doesUserExist(credential.user!.uid);
      if (!userExist) {
        EasyLoading.show(status: 'Ridercting');
        final userModel = UserModel(
          userId: credential.user!.uid,
          email: credential.user!.email!,
          displayName: credential.user!.displayName,
          imageUrl: credential.user!.photoURL,
          phone: credential.user!.phoneNumber,
          userCreationTime: Timestamp.fromDate(DateTime.now())
        );
        await userProvider.adduser(userModel);
      }
    }catch(error){
      EasyLoading.dismiss();
      rethrow;
    }
    EasyLoading.dismiss();
    if(mounted){
      Navigator.pushReplacementNamed(context, LauncherPage.routeName);
    }
  }
}
