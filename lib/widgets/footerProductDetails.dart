
import 'package:emarting/Providers/cart.dart';
import 'package:emarting/Providers/product.dart';
import 'package:emarting/Providers/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class FooterProductDetails extends StatelessWidget {
  // const FooterProductDetails({Key? key}) : super(key: key);

  final String productId;

  FooterProductDetails(this.productId);
  @override
  Widget build(BuildContext context) {
    // final favProductInfo = Provider.of<Products>(context, listen: false)
    //     .findProductById(productId);
    final favProductInfo = Provider.of<Product>(context);
    return Row(children: [
      Expanded(
        child: Container(
            decoration:
                BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
            margin: EdgeInsets.symmetric(horizontal: 2),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    )),
                onPressed: () {
                  HapticFeedback.heavyImpact();
                  favProductInfo.changeFav();
                },
                child: (!favProductInfo.isFav)
                    ? (Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.favorite_outline_sharp,
                              color: Colors.black, size: 20),
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: Text('WishList',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20)),
                          ),
                        ],
                      ))
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.favorite, color: Colors.red, size: 20),
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: Text('Wishlisted',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20)),
                          ),
                        ],
                      ))),
      ),
      Expanded(
          child: Container(
        decoration:
            BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
        margin: EdgeInsets.symmetric(horizontal: 2),
        child: Consumer<CartItems>(
          builder: (context, cartItemData, consumerChild) => ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                )),
            onPressed: () {
              HapticFeedback.heavyImpact();
              if (!cartItemData.getCartAdded(favProductInfo.id)) {
                cartItemData.addItems(
                    favProductInfo.id,
                    favProductInfo.name,
                    favProductInfo.desc,
                    favProductInfo.imageURL,
                    favProductInfo.price);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Item added to Bag!'),
                    duration: Duration(seconds: 2),
                    action: SnackBarAction(
                        label: 'UNDO',
                        onPressed: () {
                          cartItemData.removeSingleCartItem(favProductInfo.id);
                        })));
              } else {
                Navigator.of(context).pushNamed('/cart');
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_bag_outlined,
                    color: Colors.white, size: 20),
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: (!cartItemData.getCartAdded(favProductInfo.id)
                      ? Text('Add to Bag',
                          style: TextStyle(color: Colors.white, fontSize: 20))
                      : Text('Go to Bag',
                          style: TextStyle(color: Colors.white, fontSize: 20))),
                ),
              ],
            ),
          ),
        ),
      )),
    ]);
  }
}
