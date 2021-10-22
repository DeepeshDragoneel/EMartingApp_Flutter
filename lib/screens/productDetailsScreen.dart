import 'package:emarting/Providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailesScreen extends StatelessWidget {
  // const ProductDetailesScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productDetailsArgs =
        ModalRoute.of(context)!.settings.arguments as String;

    final productDetails =
        Provider.of<Products>(context, listen: false).findProductById(productDetailsArgs);

    return Scaffold(
      appBar: AppBar(title: Text(productDetails.name)),
    );
  }
}
