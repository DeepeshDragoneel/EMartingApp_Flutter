import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final String name;
  final String desc;
  final double price;
  final String imageURL;
  final double rating;
  final String author;
  bool isFav;

  Product(
      {required this.id,
      required this.name,
      required this.desc,
      required this.price,
      required this.imageURL,
      this.isFav = false,
      this.rating = 5.0,
      this.author = 'Anonymous'});

  void changeFav() {
    isFav = !isFav;
    notifyListeners();
  }
}
