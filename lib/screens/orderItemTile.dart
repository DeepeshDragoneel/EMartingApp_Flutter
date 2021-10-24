import 'package:emarting/Providers/orders.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderItemTile extends StatelessWidget {
  // const OrderItemTile({ Key? key }) : super(key: key);

  final Order order;
  OrderItemTile(this.order);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('₹${order.amount}'),
            subtitle:
                Text(DateFormat('dd MM yyyy hh:mm').format(order.dateTime)),
            trailing:
                IconButton(onPressed: () {}, icon: Icon(Icons.expand_more)),
          )
        ],
      ),
    );
  }
}
