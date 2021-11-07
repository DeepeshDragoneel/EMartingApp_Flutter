import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final String name;
  final String desc;
  final double price;
  final String imageURL;
  final double rating;
  final String author;
  final num pages;
  final num quantity;
  final String genre;
  bool isFav;

  Product(
      {required this.id,
      required this.name,
      required this.desc,
      required this.price,
      required this.imageURL,
      required this.pages,
      required this.quantity,
      this.isFav = false,
      this.rating = 5.0,
      this.author = 'Anonymous',
      this.genre = 'Unknown'});

  void changeFav() {
    isFav = !isFav;
    notifyListeners();
  }
}
