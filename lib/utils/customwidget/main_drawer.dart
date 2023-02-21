import 'package:auction/model/product_model.dart';
import 'package:auction/provider/product_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../auth/authservice.dart';
import '../../pages/launcherpage.dart';
import '../../pages/loginpage.dart';
import '../../pages/product_details.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            child: const Text('My Posted items'),
          ),

          Consumer<ProductProvider>(
            builder: (context, provider, child) {
              provider.getAllProductsbyUid(AuthService.currentUser!.uid);
              return provider.productListbyuser.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: provider.productListbyuser.length,
                        itemBuilder: (context, index) {
                          ProductModel product =
                              provider.productListbyuser[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              onTap: () => Navigator.pushNamed(
                                  context, ProductDetailsPage.routeName,
                                  arguments: product),
                              leading: CachedNetworkImage(
                                width: 75,
                                imageUrl: product.thumbnailImageUrl,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                              title: Text(product.productName),
                              trailing: Text('Bid: ${product.salePrice}'),
                            ),
                          );
                        },
                      ),
                    )
                  : Text('Noting Posted');
            },
          ),

          ListTile(
            onTap: () {
              AuthService.logout().then((value) =>
                  Navigator.pushReplacementNamed(
                      context, LauncherPage.routeName));
            },
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
