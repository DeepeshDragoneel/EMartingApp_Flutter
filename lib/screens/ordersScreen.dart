import 'package:emarting/Providers/orders.dart';
import 'package:emarting/widgets/orderItemTile.dart';
import 'package:emarting/widgets/appDrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Orders')),
      body: (orderData.orders.length == 0
          ? Center(
              child: (Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  'No orders Yet!',
                  style: Theme.of(context).textTheme.title,
                ),
              )),
            )
          : (ListView.builder(
              itemBuilder: (context, index) {
                return OrderItemTile(orderData.orders[index], index);
              },
              itemCount: orderData.orders.length,
            ))),
      // drawer: Theme(
      //   data: Theme.of(context).copyWith(
      //     canvasColor:
      //         Colors.white, //This will change the drawer background to blue.
      //     //other styles
      //   ),
      //   child: AppDrawer(),
      // ),
    );
  }
}
