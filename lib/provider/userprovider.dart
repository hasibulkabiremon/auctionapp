import 'package:auction/model/usermodel.dart';
import 'package:flutter/cupertino.dart';

import '../db/dhhelper.dart';

class UserProvider extends ChangeNotifier {
 UserModel? userModel;
 Future<void> adduser(UserModel userModel){
   return DbHelper.addUser(userModel);
 }

 Future<bool> doesUserExist(String uid) => DbHelper.doesUserExist(uid);
}