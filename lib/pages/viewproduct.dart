import 'package:auction/auth/authservice.dart';
import 'package:auction/pages/add_product_page.dart';
import 'package:auction/pages/launcherpage.dart';
import 'package:auction/pages/product_details.dart';
import 'package:auction/utils/customwidget/main_drawer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/product_provider.dart';

class ViewProductPage extends StatelessWidget {
  static const String routeName='/viewProduct';
  const ViewProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductProvider>(context, listen: false).getAllProducts();
    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            AuthService.logout();
            Navigator.pushReplacementNamed(context, LauncherPage.routeName);
          }, icon: Icon(Icons.logout))
        ],
      ) ,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddProductPage(),));
        },
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          provider.getAllProducts();
          return Column(
            children: [
              provider.productList.isEmpty ?
              const Expanded(child: Center(child: Text('No item found'),)) :
              Expanded(
                child: ListView.builder(
                  itemCount: provider.productList.length,
                  itemBuilder: (context, index) {
                    final product = provider.productList[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        onTap: () => Navigator.pushNamed(
                            context,
                            ProductDetailsPage.routeName,
                            arguments: product),
                        leading: CachedNetworkImage(
                          width: 75,
                          imageUrl: product.thumbnailImageUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                        title: Text(product.productName),
                        trailing: Text('Bid: ${product.salePrice}'),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
