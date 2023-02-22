import 'package:auction/auth/authservice.dart';
import 'package:auction/model/bidmode.dart';
import 'package:auction/model/product_model.dart';
import 'package:auction/provider/product_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import '../utils/helper_function.dart';

class ProductDetailsPage extends StatelessWidget {
  static const String routeName = 'details';

  const ProductDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String winner = '';
    TextEditingController _bidController = TextEditingController();
    TextEditingController _changeController = TextEditingController();
    ProductModel productModel =
        ModalRoute.of(context)!.settings.arguments as ProductModel;
    ProductProvider productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    Provider.of<ProductProvider>(context, listen: false).bidList;
    return Scaffold(
      appBar: AppBar(
        title: Text(productModel.productName),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              productModel.productName,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              productModel.longDescription,
              style: TextStyle(fontSize: 15),
            ),
          ),
          CachedNetworkImage(
            width: double.infinity,
            height: 200,
            imageUrl: productModel.thumbnailImageUrl,
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Bid Start from:'),
                Text(
                  productModel.salePrice.toString(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Bid Ending Day:',
                ),
                Text(
                  '${productModel.dateTime.day.toString()}/${productModel.dateTime.month.toString()}/${productModel.dateTime.year.toString()}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Consumer<ProductProvider>(
            builder: (context, provider, child) {
              provider.getAllBid(productModel.productId!);
              return Expanded(
                child: ListView.builder(
                  itemCount: provider.bidList.length,
                  itemBuilder: (context, index) {
                    final item = provider.bidList[index];
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        tileColor: Colors.lightBlueAccent,
                        leading: Text((index + 1).toString()),
                        title: Text(item.bid!),
                      ),
                    );
                  },
                ),
              );
            },
          ),
          if (productModel.dateTime.compareTo(DateTime.now()) > 0)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: _bidController,
                decoration: const InputDecoration(
                  filled: true,
                  labelText: 'Enter your New Bid',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field must not be empty';
                  }
                  return null;
                },
              ),
            ),
          if (productModel.dateTime.compareTo(DateTime.now()) > 0)
            ElevatedButton(
                onPressed: () {
                  addBid(context, productProvider, productModel,
                      _bidController.text);
                  _bidController.clear();
                },
                child: Text('BID')),
          if (productModel.dateTime.compareTo(DateTime.now()) == 0 ||
              productModel.dateTime.compareTo(DateTime.now()) < 0)
            Consumer<ProductProvider>(
              builder: (context, bidProvider, child) {
                final winner = bidProvider.winner;
                if(winner.bidId != null){
                  return ListTile(
                    tileColor: Colors.green,
                    title: Text('WINNER'),
                    subtitle: Text(winner.userId!),
                    trailing: Text(winner.bid!),
                  );
                }
                return Container();
              },
            )
        ],
      ),
    );
  }

  Future<void> addBid(BuildContext context, ProductProvider productProvider,
      ProductModel productModel, String value) async {
    EasyLoading.show(status: 'Please wait', dismissOnTap: false);
    if (value.isNotEmpty && int.parse(value) > productModel.salePrice) {
      try {
        final bidModel = BidModel(
            userId: AuthService.currentUser!.uid,
            productId: productModel.productId!,
            bid: value);
        await productProvider.addNewBid(bidModel);
        EasyLoading.dismiss();
        showMsg(context, 'Saved');
      } catch (e) {
        showMsg(context, 'Something went wrong');
        EasyLoading.dismiss();
      }
    } else {
      EasyLoading.dismiss();
      showMsg(context, 'Please Enter your BID amount');
    }
  }
}
