import 'package:emarting/widgets/shopProductTile.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';

class ShopMainScreen extends StatelessWidget {
  // const ShopMainScreen({ Key? key }) : super(key: key);

  final List<Product> shopProducts = [
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
      desc: 'A nice pair of trousers.',
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
      name: 'A Pan',
      desc: 'Prepare any meal you want.',
      price: 49.99,
      imageURL:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("EMarting")),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: GridView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: shopProducts.length,
          itemBuilder: (context, index) {
            return ShopProductTile(
                shopProducts[index].id,
                shopProducts[index].name,
                shopProducts[index].desc,
                shopProducts[index].imageURL);
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.75,
          ),
        ),
      ),
    );
  }
}
