import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String name;
  final String desc;
  final String imageURL;
  final int quantity;
  final double price;

  CartItem(
      {required this.id,
      required this.name,
      required this.desc,
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

  void addItems(String productId, String name,String desc, String imageURL, double price) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
          productId,
          (value) => CartItem(
              id: value.id,
              name: value.name,
              desc: value.desc,
              imageURL: value.imageURL,
              quantity: value.quantity + 1,
              price: value.price));
    } else {
      _cartItems.putIfAbsent(
          productId,
          () => CartItem(
              id: DateTime.now().toString(),
              name: name,
              desc: desc,
              imageURL: imageURL,
              quantity: 1,
              price: price));
    }
    notifyListeners();
  }

  void removeCartItem(String productId){
     _cartItems.remove(productId);
     notifyListeners();
  }

  bool getCartAdded(String productId) {
    if (_cartItems.containsKey(productId)) {
      return true;
    }
    return false;
  }

  double get getTotalPrice {
    double totalPrice = 0.0;
    _cartItems.forEach(
        (value, cartItem) => totalPrice += cartItem.price * cartItem.quantity);
    return totalPrice;
  }

  void clearCartItems() {
    _cartItems.clear();
    notifyListeners();
  }
}
