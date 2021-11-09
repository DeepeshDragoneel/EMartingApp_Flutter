import 'dart:ffi';

import 'package:emarting/Providers/products.dart';
import 'package:emarting/widgets/ProductReviews.dart';
import 'package:emarting/widgets/footerProductDetails.dart';
import 'package:emarting/widgets/ratingPercentageBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;

class ProductDetailesScreen extends StatefulWidget {
  // const ProductDetailesScreen({ Key? key }) : super(key: key);

  @override
  _ProductDetailesScreenState createState() => _ProductDetailesScreenState();
}

class _ProductDetailesScreenState extends State<ProductDetailesScreen> {
  var ratingPerStar;
  bool isInit = false;
  bool ratingLoaded = false;
  var productDetailsArgs = '';
  @override
  void didChangeDependencies() {
    if (!isInit) {
      productDetailsArgs = ModalRoute.of(context)!.settings.arguments as String;
      Provider.of<Products>(context, listen: false)
          .getRatingPerStar(productDetailsArgs)
          .then((value) {
        setState(() {
          ratingPerStar = value;
          ratingLoaded = true;
        });
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              width: double.infinity,
              child: Text('Only ${productDetails.quantity} left',
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
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
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${productDetails.rating.toStringAsFixed(1)}',
                              style: TextStyle(
                                  fontSize: 45, fontWeight: FontWeight.w100),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 6),
                              child: Icon(
                                Icons.star,
                                size: 25,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ],
                        ),
                        flex: 4),
                    Container(
                      height: 100,
                      child: VerticalDivider(
                        color: Colors.grey,
                      ),
                    ),
                    Flexible(
                        fit: FlexFit.tight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: RatingPercentageBar(
                                    percentage: !ratingLoaded
                                        ? 0
                                        : ratingPerStar['five'],
                                    starNumber: '5')),
                            SizedBox(
                              height: 3,
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: RatingPercentageBar(
                                    percentage: !ratingLoaded
                                        ? 0
                                        : ratingPerStar['four'],
                                    starNumber: '4')),
                            SizedBox(
                              height: 3,
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: RatingPercentageBar(
                                    percentage: !ratingLoaded
                                        ? 0
                                        : ratingPerStar['three'],
                                    starNumber: '3')),
                            SizedBox(
                              height: 3,
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: RatingPercentageBar(
                                    percentage: !ratingLoaded
                                        ? 0
                                        : ratingPerStar['two'],
                                    starNumber: '2')),
                            SizedBox(
                              height: 3,
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: RatingPercentageBar(
                                    percentage: !ratingLoaded
                                        ? 0
                                        : ratingPerStar['one'],
                                    starNumber: '1')),
                            SizedBox(
                              height: 3,
                            ),
                          ],
                        ),
                        flex: 6),
                  ]),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  ProductReviews(productDetails.id),
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
