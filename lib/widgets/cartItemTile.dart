import 'package:emarting/Providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItemTile extends StatelessWidget {
  // const CartItemTile({ Key? key }) : super(key: key);

  final String id;
  final String productId;
  final String name;
  final String desc;
  final double price;
  final int quantity;
  final String imageURL;
  CartItemTile(
      {required this.id,
      required this.productId,
      required this.name,
      required this.desc,
      required this.price,
      required this.quantity,
      required this.imageURL});

  @override
  Widget build(BuildContext context) {
    final cartItems = Provider.of<CartItems>(context);
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        decoration: BoxDecoration(color: Colors.redAccent[100]),
        child: Icon(Icons.delete, size: 50, color: Colors.white),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(10),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        cartItems.removeCartItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 3),
        child: Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(5),
                  width: 130,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    // border: Border.all(color: Colors.black),
                    // image: DecorationImage(
                    //   fit: BoxFit.fill,
                    //   image: NetworkImage(imageURL),
                    // ),
                  ),
                  child: Image.network(imageURL),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    // decoration: BoxDecoration(
                    //   border: Border.all(color: Colors.black),
                    // ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14)),
                              IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(),
                                  icon: Icon(
                                    Icons.cancel,
                                    color: Colors.black.withOpacity(0.5),
                                    size: 23,
                                  ),
                                  onPressed: () {
                                    cartItems.removeCartItem(productId);
                                  })
                            ]),
                        SizedBox(
                          height: 7,
                        ),
                        Text(desc.length > 90 ? desc.substring(0, 90) : desc,
                            style: TextStyle(fontSize: 14)),
                        SizedBox(
                          height: 7,
                        ),
                        Text('Quantity: ${quantity}',
                            style: TextStyle(
                                fontFamily: 'RobotoCondensed', fontSize: 13)),
                        SizedBox(
                          height: 7,
                        ),
                        Text('₹ ${quantity * price}',
                            style: TextStyle(
                                fontFamily: 'RobotoCondensed',
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
