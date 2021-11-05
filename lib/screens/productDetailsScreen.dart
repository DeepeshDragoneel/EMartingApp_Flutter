import 'package:emarting/Providers/products.dart';
import 'package:emarting/widgets/footerProductDetails.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailesScreen extends StatelessWidget {
  // const ProductDetailesScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productDetailsArgs =
        ModalRoute.of(context)!.settings.arguments as String;

    final productDetails = Provider.of<Products>(context, listen: false)
        .findProductById(productDetailsArgs);
    final productData = Provider.of<Products>(context);
    final shopProducts = productData.products;
    final productIdx = Provider.of<Products>(context, listen: false)
        .findProductIdx(productDetailsArgs);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(productDetails.name)),
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: Column(children: [
            Container(
              color: Colors.white,
              width: double.infinity,
              height: constraints.maxHeight * 0.7,
              child: Image.network(
                productDetails.imageURL,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(productDetails.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              width: double.infinity,
              child: Text('By ${productDetails.author}',
                  style: TextStyle(fontSize: 14, color: Colors.grey)),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: double.infinity,
              child: Text('₹ ${productDetails.price}',
                  style: TextStyle(
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.bold,
                      fontSize: 20)),
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: double.infinity,
                child: Text(
                  productDetails.desc,
                  style: TextStyle(
                      fontWeight: FontWeight.w700, color: Colors.black54),
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Divider(
                  color: Colors.grey,
                ),
              ],
            ),
            Container(
                child: Column(children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: double.infinity,
                child: Text(
                  'Rating & Reviews',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              Row(children: [
                Expanded(
                    child: Text(
                      '${productDetails.rating}',
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.w100),
                    ),
                    flex: 4),
                Expanded(child: Text('Yppppppppppppppp'), flex: 6),
              ])
            ])),
          ]),
        );
      }),
      persistentFooterButtons: [
        ChangeNotifierProvider.value(
          value: shopProducts[productIdx],
          child: FooterProductDetails(productDetails.id),
        )
      ],
    );
  }
}
