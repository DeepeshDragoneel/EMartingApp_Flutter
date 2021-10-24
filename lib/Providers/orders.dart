import 'package:emarting/Providers/cart.dart';
import 'package:flutter/material.dart';

class Order {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  Order(
      {required this.id,
      required this.amount,
      required this.products,
      required this.dateTime});
}

class Orders with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cart, double amount) {
    _orders.insert(
        0,
        Order(
            id: DateTime.now().toString(),
            amount: amount,
            products: cart,
            dateTime: DateTime.now()));
    notifyListeners();
  }
}
