import 'package:auction/model/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/product_model.dart';

class DbHelper {
  static final _db = FirebaseFirestore.instance;

  static Future<void> addUser(UserModel userModel){
    return _db.collection(collectionUser).doc(userModel.userId).set(userModel.toMap());
  }

  static Future<bool> doesUserExist(String uid) async{
    final snapshot = await _db.collection(collectionUser).doc(uid).get();
    return snapshot.exists;
  }

  static Future<void> addNewProduct(
      ProductModel productModel) {
    final wb = _db.batch();
    final productDoc = _db.collection(collectionProduct).doc();
    productModel.productId = productDoc.id;
    wb.set(productDoc, productModel.toMap());
    return wb.commit();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllProducts() =>
      _db.collection(collectionProduct).snapshots();

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllProductsbyUid(String uid) =>
      _db.collection(collectionProduct).where(productFieldUploader, isEqualTo: uid).snapshots();

}