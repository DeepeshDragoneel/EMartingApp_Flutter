import 'package:emarting/Providers/products.dart';
import 'package:emarting/widgets/footerProductDetails.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailesScreen extends StatelessWidget {
  // const ProductDetailesScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productDetailsArgs =
        ModalRoute.of(context)!.settings.arguments as String;

    final productDetails = Provider.of<Products>(context, listen: false)
        .findProductById(productDetailsArgs);
    final productData = Provider.of<Products>(context);
    final shopProducts = productData.products;
    final productIdx = Provider.of<Products>(context, listen: false)
        .findProductIdx(productDetailsArgs);

    return Scaffold(
      appBar: AppBar(title: Text(productDetails.name)),
      // bottomNavigationBar: BottomNavigationBar(items: [
      //   BottomNavigationBarItem(
      //       icon: Icon(Icons.favorite), title: Text('Favorite')),
      //   BottomNavigationBarItem(
      //       icon: Icon(Icons.shopping_bag_outlined), title: Text('Favorite')),
      // ]),
      persistentFooterButtons: [
        ChangeNotifierProvider.value(
          value: shopProducts[productIdx],
          child: FooterProductDetails(productDetails.id),
        )
      ],
    );
  }
}
