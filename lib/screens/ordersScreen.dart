import 'package:emarting/Providers/orders.dart';
import 'package:emarting/screens/orderItemTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Orders')),
      body: (orderData.orders.length==0?(
        Text('No orders');
      ):(
        ListView.builder(itemBuilder: (context, index){
          return OrderItemTile(orderData.orders[index].);
        },itemCount: orderData.orders.length,)
      )),
    );
  }
}