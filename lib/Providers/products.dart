import 'package:emarting/Providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'product.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_config/flutter_config.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

class Products with ChangeNotifier {
  int _remainingProducts = 1;
  int pageNumber = 0;
  bool _isLoading = false;
  List<Product> _products = [
    // Product(
    //   id: 'p1',
    //   name: 'Red Shirt',
    //   desc: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageURL:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   name: 'Trousers',
    //   desc:
    //       'A nice pair of trousers. wear it to feel the fabric, we bet you wont regret!',
    //   price: 59.99,
    //   imageURL:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   name: 'Yellow Scarf',
    //   desc: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageURL:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   name: 'Pan',
    //   desc: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageURL:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  List<Product> get products {
    return [..._products];
  }

  //get _isLoading
  bool get isLoading {
    return _isLoading;
  }

  //get _remainingProducts
  int get remainingProducts {
    return _remainingProducts;
  }

  void toogleLoading() {
    _isLoading = !_isLoading;
    if (_isLoading == true) {
      notifyListeners();
    }
  }

  //get all products
  Future<void> getAndSetProducts() async {
    try {
      // toogleLoading();
      if (_remainingProducts <= 0) {
        return;
      }
      pageNumber += 1;
      final queryParameters = {
        'pageNumber': pageNumber.toString(),
        'query': "",
      };
      final uri =
          Uri.http(FlutterConfig.get('REST_URL'), '/shop', queryParameters);
      // print(uri);
      final result = await http.get(uri);
      _remainingProducts = json.decode(result.body)['count'];
      var shopProducts = json.decode(result.body)['products'];
      print(json.decode(result.body)['products'][0]);
      //add every item of shopProducts to _products
      shopProducts.forEach((product) => _products.add(Product(
            id: product['_id'],
            name: product['title'],
            desc: product['desc'],
            price: product['price'].toDouble(),
            imageURL: product['image'],
            rating: product['rating'].toDouble(),
            author: product['author'],
            quantity: product['quantity'].toInt(),
            genre: product['genre'],
            pages: product['pages'].toInt(),
          )));
      // toogleLoading();
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<Map<String, dynamic>> getRatingPerStar(String id) async {
    try {
      print('Geting rating for id: ${id}');
      final queryParameters = {'query': id};
      final uri =
          Uri.https(FlutterConfig.get('REST_URL'), '/getRatingPerStar/${id}');
      print(uri);
      final result = await http.get(uri);
      final ratingPerStar = json.decode(result.body);
      print(ratingPerStar);
      return ratingPerStar;
    } catch (error) {
      print(error);
      throw (error);
    }
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

  void updateProducts(
      String id, Product product, var imageFile, String token) async {
    try {
      print(imageFile);
      if (imageFile == null) {
        final details = {
          'id': product.id,
          'title': product.name,
          'price': product.price,
          'desc': product.desc,
          'genre': product.genre,
          'pages': product.pages,
          'quantity': product.quantity,
          'author': product.author,
          'image': product.imageURL,
        };
        final uri = Uri.http(
            FlutterConfig.get('REST_URL'), '/admin/editProductWithOutImg');
        final result = await http.post(uri,
            headers: {
              "content-type": "application/json",
              "accept": "application/json",
            },
            body: json.encode(details));
      } else {
        final details = {
          'id': product.id,
          'title': product.name,
          'price': product.price,
          'desc': product.desc,
          'genre': product.genre,
          'pages': product.pages,
          'quantity': product.quantity,
          'author': product.author,
          'image': product.imageURL,
        };
        final uri = (Uri.https(
            FlutterConfig.get('REST_URL'), 'admin/editProduct'));
        print(uri);
        var request = http.MultipartRequest('POST', uri);
        request.headers.addAll({
          "content-type": "multipart/form-data",
        });
        request.fields['data'] = json.encode(details);
        request.files
            .add(await http.MultipartFile.fromPath('file', imageFile.path));
        // request.files.add(
        //     await http.MultipartFile.fromPath('data', json.encode(detailes)));
        print(request.files);
        var response = await request.send();
        print(response);
      }
      final updateindProductIdx =
          _products.indexWhere((product) => product.id == id);
      if (updateindProductIdx >= 0) {
        print('Updating products! ${updateindProductIdx}');
        _products[updateindProductIdx] = product;
      }
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  void deleteProductById(String id) {
    _products.removeWhere((product) => product.id == id);
    notifyListeners();
  }

  void addProduct(Product product, PickedFile imageFile, String token) async {
    try {
      final newProduct = Product(
          id: DateTime.now().toString(),
          name: product.name,
          desc: product.desc,
          price: product.price,
          imageURL: product.imageURL,
          rating: product.rating,
          pages: product.pages,
          quantity: product.quantity,
          author: product.author,
          isFav: product.isFav,
          genre: product.genre);
      final details = {
        'title': product.name,
        'price': product.price,
        'desc': product.desc,
        'genre': product.genre,
        'pages': product.pages,
        'quantity': product.quantity,
        'author': product.author,
      };
      // _products.insert(0, newProduct);
      // print(newProduct);
      // print(imageFile.path);
      // notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey('userData')) {
        return;
      }
      final localUserData = json.decode(prefs.getString('userData') as String);
      token = localUserData['token'];
      print(token);
      final result = await http.post(
          Uri.https(
            FlutterConfig.get('REST_URL'),
            '/auth',
          ),
          headers: {
            "content-type": "application/json",
            "accept": "application/json",
          },
          body: json.encode({'token': token}));
      final userId = json.decode(result.body)['_id'];
      print(json.decode(result.body)['_id']);
      final uri = (Uri.https(
          FlutterConfig.get('REST_URL'), 'admin/addProduct/${userId}'));
      print(uri);
      var request = http.MultipartRequest('POST', uri);
      request.headers.addAll({
        "content-type": "multipart/form-data",
      });
      request.fields['data'] = json.encode(details);
      request.files
          .add(await http.MultipartFile.fromPath('file', imageFile.path));
      // request.files.add(
      //     await http.MultipartFile.fromPath('data', json.encode(detailes)));
      print(request.files);
      var response = await request.send();
      // print(response.statusCode);
    } catch (e) {
      print(e);
    }
  }
}
