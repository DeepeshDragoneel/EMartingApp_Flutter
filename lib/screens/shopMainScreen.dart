import 'package:emarting/Providers/cart.dart';
import 'package:emarting/screens/favoritesScreen.dart';
import 'package:emarting/widgets/badge.dart';
import 'package:emarting/widgets/shopProductTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/product.dart';
import '../Providers/products.dart';

class ShopMainScreen extends StatelessWidget {
  // const ShopMainScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final shopProducts = productData.products;
    return Scaffold(
      appBar: AppBar(
        title: Text("EMarting"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/favoriteProducts');
            },
            icon: Icon(Icons.favorite_outline_sharp, color: Colors.white),
            color: Colors.red,
          ),
          Consumer<CartItems>(builder: (context, cartData, child) {
            return Badge(
                child: child as Widget,
                value: cartData.cartItemsLength.toString());
          }, child: IconButton(
                    onPressed: () {}, icon: Icon(Icons.shopping_bag_outlined)),),
        ],
        // backgroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: GridView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: shopProducts.length,
          itemBuilder: (context, index) {
            return ChangeNotifierProvider.value(
                // create: (context) => shopProducts[index],
                value: shopProducts[index],
                child: ShopProductTile(
                    // shopProducts[index].id,
                    // shopProducts[index].name,
                    // shopProducts[index].desc,
                    // shopProducts[index].imageURL),
                    ));
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
