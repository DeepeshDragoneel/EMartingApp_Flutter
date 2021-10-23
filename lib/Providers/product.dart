import 'package:flutter/material.dart';

class Product with ChangeNotifier{
  final String id;
  final String name;
  final String desc;
  final double price;
  final String imageURL;
  bool isFav;

  Product(
      {required this.id,
      required this.name,
      required this.desc,
      required this.price,
      required this.imageURL,
      this.isFav = false});

  void changeFav(){
    isFav= !isFav;
    notifyListeners();
  }
}
