import 'package:auction/model/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DbHelper {
  static final _db = FirebaseFirestore.instance;

  static Future<void> addUser(UserModel userModel){
    return _db.collection(collectionUser).doc(userModel.userId).set(userModel.toMap());
  }

  static Future<bool> doesUserExist(String uid) async{
    final snapshot = await _db.collection(collectionUser).doc(uid).get();
    return snapshot.exists;
  }
}