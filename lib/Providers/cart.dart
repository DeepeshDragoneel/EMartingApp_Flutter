import 'package:emarting/Providers/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  Future<void> fetchAndSetCartItems(String id) async {
    _cartItems = {};
    final uri = Uri.http(FlutterConfig.get('REST_URL'), '/cart/${id}');
    // print(uri);
    final result = await http.get(uri);
    // print(json.decode(result.body));
    final cartProducts = json.decode(result.body);
    print(cartProducts[0]);
    cartProducts.forEach((product) {
      _cartItems.putIfAbsent(
          product['_id'],
          () => CartItem(
              id: product['productId']['_id'],
              name: product['productId']['title'],
              desc: product['productId']['desc'],
              imageURL: product['productId']['image'],
              quantity: product['quantity'],
              price: product['productId']['price'].toDouble()));
    });
    notifyListeners();
  }

  void addItems(String userId, Product product) async {
    print(json.encode(product.id));
    final url = Uri.http(
      FlutterConfig.get('REST_URL'),
      '/appCart/${userId}',
    );
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'productId': product.id,
      }),
    );
    final responseData = (response.statusCode);
    print(responseData);
    if (_cartItems.containsKey(product.id)) {
      _cartItems.update(
          product.id,
          (value) => CartItem(
              id: value.id,
              name: value.name,
              desc: value.desc,
              imageURL: value.imageURL,
              quantity: value.quantity + 1,
              price: value.price));
    } else {
      _cartItems.putIfAbsent(
          product.id,
          () => CartItem(
              id: DateTime.now().toString(),
              name: product.name,
              desc: product.desc,
              imageURL: product.imageURL,
              quantity: 1,
              price: product.price));
    }
    notifyListeners();
  }

  void removeCartItem(String id, String productId, String cartId) async {
    _cartItems.remove(cartId);
    print(productId);
    // print(cartId);
    final url = Uri.http(
      FlutterConfig.get('REST_URL'),
      '/appCart/delete/${id}',
    );
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'productId': productId,
      }),
    );
    final responseData = (response.statusCode);
    print(responseData);
    notifyListeners();
  }

  void removeSingleCartItem(String productId) {
    if (_cartItems.containsKey(productId)) {
      if (_cartItems[productId]!.quantity > 1) {
        _cartItems.update(
            productId,
            (value) => CartItem(
                id: value.id,
                desc: value.desc,
                name: value.name,
                imageURL: value.imageURL,
                quantity: value.quantity - 1,
                price: value.price));
      } else {
        _cartItems.remove(productId);
      }
      notifyListeners();
    }
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
