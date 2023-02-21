import 'package:cloud_firestore/cloud_firestore.dart';

const String collectionProduct = 'Products';
const String productFieldId = 'productId';
const String productFieldName = 'productName';
const String productFieldCategory = 'category';
const String productFieldShortDescription = 'shortDescription';
const String productFieldLongDescription = 'LongDescription';
const String productFieldSalePrice = 'salePrice';
const String productFieldStock = 'stock';
const String productFieldAvgRating = 'avgRating';
const String productFieldDiscount = 'discount';
const String productFieldThumbnail = 'thumbnail';
const String productFieldImages = 'images';
const String productFieldAvailable = 'available';
const String productFieldFeatured = 'featured';
const String productFieldDate = 'endDate';
const String productFieldUploader = 'uploader';

class ProductModel {
  String? productId;
  String productName;
  String longDescription;
  num salePrice;
  String thumbnailImageUrl;
  DateTime dateTime;
  String uploader;

  ProductModel(
      {this.productId,
      required this.productName,
      required this.longDescription,
      required this.salePrice,
      required this.thumbnailImageUrl,
      required this.dateTime,
      required this.uploader,
      });

  Map<String, dynamic> toMap() {
    return <String,dynamic>{
      productFieldId : productId,
      productFieldName : productName,
      productFieldLongDescription : longDescription,
      productFieldSalePrice : salePrice,
      productFieldThumbnail : thumbnailImageUrl,
      productFieldUploader : uploader,
      productFieldDate: dateTime,

    };
  }

  factory ProductModel.fromMap(Map<String,dynamic> map) => ProductModel(
    productId: map[productFieldId],
    productName: map[productFieldName],
    longDescription: map[productFieldLongDescription],
    salePrice: map[productFieldSalePrice],
    thumbnailImageUrl: map[productFieldThumbnail],
    uploader: map[productFieldUploader],
    dateTime: (map[productFieldDate] as Timestamp).toDate()
  );
}