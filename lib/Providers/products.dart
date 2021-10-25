import 'package:flutter/material.dart';
import 'product.dart';

class Products with ChangeNotifier {
  List<Product> _products = [
    Product(
      id: 'p1',
      name: 'Red Shirt',
      desc: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageURL:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      name: 'Trousers',
      desc:
          'A nice pair of trousers. wear it to feel the fabric, we bet you wont regret!',
      price: 59.99,
      imageURL:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      name: 'Yellow Scarf',
      desc: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageURL:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      name: 'Pan',
      desc: 'Prepare any meal you want.',
      price: 49.99,
      imageURL:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<Product> get products {
    return [..._products];
  }

  Product findProductById(String id) {
    return _products.firstWhere((product) => product.id == id);
  }

  int findProductIdx(String id) {
    return _products.indexWhere((product) => product.id == id);
  }

  List<Product> getFavProducts() {
    return [..._products.where((product) => product.isFav)];
  }

  void removeFavProduct(String id) {
    List<Product> favProducts =
        _products.where((product) => product.isFav).toList();
    favProducts.forEach((product) {
      if (product.id == id) {
        product.isFav = false;
      }
    });
    notifyListeners();
    // return [..._products.where((product) => product.isFav)];
  }

  void addProduct(Product product) {
    final newProduct = Product(
        id: DateTime.now().toString(),
        name: product.name,
        desc: product.desc,
        price: product.price,
        imageURL: product.imageURL);
    _products.insert(0, newProduct);
    notifyListeners();
  }
}
