import 'package:emarting/Providers/products.dart';
import 'package:emarting/screens/myProductTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyProductScreen extends StatelessWidget {
  const MyProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsInfo = Provider.of<Products>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Products'),
          actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
        ),
        backgroundColor: Colors.white,
        body: Padding(
            padding: EdgeInsets.all(5),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Column(children: [
                  MyProductTile(productsInfo.products[index].name,
                      productsInfo.products[index].imageURL),
                  Divider(color: Colors.black54,),
                ]);
              },
              itemCount: productsInfo.products.length,
            )));
  }
}
