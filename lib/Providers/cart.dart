import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String name;
  final String imageURL;
  final int quantity;
  final double price;

  CartItem(
      {required this.id,
      required this.name,
      required this.imageURL,
      required this.quantity,
      required this.price});
}

class CartItems with ChangeNotifier {
  Map<String, CartItem> _cartItems = {};

  Map<String, CartItem> get cartItems {
    return {..._cartItems};
  }

  int get cartItemsLength {
    return _cartItems.length;
  }

  void addItems(String productId, String name, String imageURL, double price) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
          productId,
          (value) => CartItem(
              id: value.id,
              name: value.name,
              imageURL: value.imageURL,
              quantity: value.quantity + 1,
              price: value.price));
    } else {
      _cartItems.putIfAbsent(
          productId,
          () => CartItem(
              id: DateTime.now().toString(),
              name: name,
              imageURL: imageURL,
              quantity: 1,
              price: price));
    }
    notifyListeners();
  }
}
