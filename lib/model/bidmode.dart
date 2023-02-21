const String collectionBid = 'Bid';
const String collectionFieldBidId = 'bidId';
const String collectionFieldUserId = 'userId';
const String collectionFieldProductId = 'productId';
const String collectionFieldBid = 'bid';

class BidModel {
  String? bidId;
  String userId;
  String productId;
  String bid;

  BidModel({
    this.bidId,
    required this.userId,
    required this.productId,
    required this.bid,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      collectionFieldBidId: bidId,
      collectionFieldUserId: userId,
      collectionFieldProductId: productId,
      collectionFieldBid: bid
    };
  }

  factory BidModel.fromMap(Map<String, dynamic>map) =>
      BidModel(
        bidId: map[collectionFieldBidId],
        userId: map[collectionFieldUserId],
        productId: map[collectionFieldProductId],
        bid: map[collectionFieldBid],
      );
}
