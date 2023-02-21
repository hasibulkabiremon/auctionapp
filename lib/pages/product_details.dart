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
    TextEditingController _bidController = TextEditingController();
    TextEditingController _changeController = TextEditingController();
    ProductModel productModel = ModalRoute.of(context)!.settings.arguments as ProductModel;
    ProductProvider productProvider = Provider.of<ProductProvider>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(productModel.productName),
      ),
      body: Column(
        children: [
          Text(productModel.productName),
          Text(productModel.longDescription),
          CachedNetworkImage(
            width: double.infinity,
            height: 200,
            imageUrl: productModel.thumbnailImageUrl,
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Text(productModel.salePrice.toString()),
          Text(productModel.dateTime.toString()),
          
          Consumer<ProductProvider>(
            builder: (context, provider, child) {
            provider.getAllBid(productModel.productId!);
            return Expanded(
              child: ListView.builder(
                  itemCount: provider.bidList.length,
                  itemBuilder: (context, index) {
                    final item = provider.bidList[index];
                    return ListTile(
                      leading: Text((index+1).toString()),
                      title: Text(item.bid),
                      // trailing: ElevatedButton(child: Text('Change'),
                      // onPressed: (){
                      //   addBid(context, productProvider, productModel, _changeController.text);
                      // },
                      // ),
                    );
                  },),
            );
          },),

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
                if (value == null || value.isEmpty ) {
                  return 'This field must not be empty';
                }
                return null;
              },
            ),
          ),
          ElevatedButton(onPressed: (){

            addBid(context, productProvider, productModel, _bidController.text);
            _bidController.clear();
          }, child: Text('BID')),
        ],
      ),
    );
  }

  Future<void> addBid(BuildContext context,ProductProvider productProvider,ProductModel productModel,String value) async {
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
    }else{
      EasyLoading.dismiss();
      showMsg(context, 'Please Enter your BID amount');
    }

    }


}
