import 'package:emarting/Providers/auth.dart';
import 'package:emarting/Providers/cart.dart';
import 'package:emarting/Providers/orders.dart';
import 'package:emarting/widgets/cartItemTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isInit = false;

  @override
  void didChangeDependencies() async {
    if (!isInit) {
      final userId = await Provider.of<Auth>(context, listen: false).userId;
      print(userId);
      await Provider.of<CartItems>(context, listen: false)
          .fetchAndSetCartItems(userId);
      isInit = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final cartItemsInfo = Provider.of<CartItems>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Shopping Bag')),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(10),
            child: Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Amount:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '₹ ${cartItemsInfo.getTotalPrice}',
                      style: TextStyle(
                        fontFamily: 'RobotoCondensed',
                        fontSize: 20,
                      ),
                    )
                  ],
                )),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    return CartItemTile(
                        id: cartItemsInfo.cartItems.values.toList()[index].id,
                        productId: cartItemsInfo.cartItems.keys.toList()[index],
                        name:
                            cartItemsInfo.cartItems.values.toList()[index].name,
                        desc:
                            cartItemsInfo.cartItems.values.toList()[index].desc,
                        price: cartItemsInfo.cartItems.values
                            .toList()[index]
                            .price,
                        quantity: cartItemsInfo.cartItems.values
                            .toList()[index]
                            .quantity,
                        imageURL: cartItemsInfo.cartItems.values
                            .toList()[index]
                            .imageURL);
                  },
                  itemCount: cartItemsInfo.cartItemsLength))
        ],
      ),
      persistentFooterButtons: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(children: [
            Expanded(child:
                Consumer<Orders>(builder: (context, orderData, consumerChild) {
              return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(15),
                  ),
                  onPressed: (cartItemsInfo.cartItemsLength != 0)
                      ? () {
                          orderData.addOrder(
                              cartItemsInfo.cartItems.values.toList(),
                              cartItemsInfo.getTotalPrice);
                          cartItemsInfo.clearCartItems();
                        }
                      : null,
                  child: Text('PLACE ORDER',
                      style: TextStyle(
                          fontFamily: 'RobotoCondensed', fontSize: 15)));
            })),
          ]),
        )
      ],
    );
  }
}
