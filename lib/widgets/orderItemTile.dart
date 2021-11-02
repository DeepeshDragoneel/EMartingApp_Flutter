import 'package:emarting/Providers/orders.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';

class OrderItemTile extends StatefulWidget {
  // const OrderItemTile({ Key? key }) : super(key: key);

  final Order order;
  final int index;
  OrderItemTile(this.order, this.index);

  @override
  _OrderItemTileState createState() => _OrderItemTileState();
}

class _OrderItemTileState extends State<OrderItemTile> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              child: Text((widget.index + 1).toString()),
            ),
            title: Text('₹${widget.order.amount}'),
            subtitle: Text(
                DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime)),
            trailing: IconButton(
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
                icon: Icon(!_expanded ? Icons.expand_more : Icons.expand_less)),
          ),
          if (_expanded)
            Container(
              height: min(widget.order.products.length * 20.0 + 10.0, 180.0),
              child: ListView(
                children: widget.order.products.map((product) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Text(product.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15)),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Text('x ${product.quantity.toString()}',
                                style: TextStyle(fontSize: 15)),
                          ),
                        ],
                      ),
                      Container(
                          padding: EdgeInsets.all(5),
                          child: Text('₹ ${product.price * product.quantity}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14)))
                    ],
                  );
                }).toList(),
              ),
            )
        ],
      ),
    );
  }
}
