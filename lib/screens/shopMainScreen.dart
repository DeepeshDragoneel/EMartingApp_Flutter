import 'package:emarting/widgets/shopProductTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../Providers/products.dart';

class ShopMainScreen extends StatelessWidget {
  // const ShopMainScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final shopProducts = productData.products;
    return Scaffold(
      appBar: AppBar(title: Text("EMarting")),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: GridView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: shopProducts.length,
          itemBuilder: (context, index) {
            return ShopProductTile(
                shopProducts[index].id,
                shopProducts[index].name,
                shopProducts[index].desc,
                shopProducts[index].imageURL);
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.75,
          ),
        ),
      ),
    );
  }
}
