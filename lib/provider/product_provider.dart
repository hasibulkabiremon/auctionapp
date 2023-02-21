import 'dart:io';
import 'package:auction/model/bidmode.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../db/dhhelper.dart';
import '../model/product_model.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> productList = [];
  List<ProductModel> productListbyuser = [];
  List<BidModel> bidList = [];


  getAllProducts() {
    DbHelper.getAllProducts().listen((snapshot) {
      productList = List.generate(snapshot.docs.length, (index) =>
          ProductModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  getAllProductsbyUid(String uid) {
    DbHelper.getAllProductsbyUid(uid).listen((snapshot) {
      productListbyuser = List.generate(snapshot.docs.length, (index) =>
          ProductModel.fromMap(snapshot.docs[index].data()));
      notifyListeners();
    });
  }

  getAllBid(String productId){
    DbHelper.getAllBid(productId).listen((snapshot) {
      bidList = List.generate(snapshot.docs.length, (index) =>
      BidModel.fromMap(snapshot.docs[index].data())
      );
      notifyListeners();
    });
  }


  Future<String> uploadImage(String thumbnailImageLocalPath) async {
    final photoRef = FirebaseStorage.instance
        .ref()
        .child('ProductImages/${DateTime.now().millisecondsSinceEpoch}');
    final uploadTask = photoRef.putFile(File(thumbnailImageLocalPath));
    final snapshot = await uploadTask.whenComplete(() => null);
    return snapshot.ref.getDownloadURL();
  }

  Future<void> addNewProduct(ProductModel productModel) {
    return DbHelper.addNewProduct(productModel);
  }

  Future<void> addNewBid(BidModel bidModel){
    return DbHelper.addNewBid(bidModel);
  }

  Future<void> deleteImage(String downloadUrl) {
    return FirebaseStorage.instance.refFromURL(downloadUrl).delete();
  }

}