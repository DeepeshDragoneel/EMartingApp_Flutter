import 'package:emarting/Providers/comments.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductReviews extends StatefulWidget {
  // const ProductReviews({Key? key}) : super(key: key);
  final String _productId;
  ProductReviews(this._productId);

  @override
  _ProductReviewsState createState() => _ProductReviewsState();
}

class _ProductReviewsState extends State<ProductReviews> {
  bool isInit = false;

  @override
  void didChangeDependencies() async {
    if (!isInit) {
      await Provider.of<Comments>(context).getAndSetComments(widget._productId);
      // print('Yo !${Provider.of<Comments>(context).remainingComments}');
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 16),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            // border: Border.all(
            //   color: Colors.grey[300] as Color,
            //   width: 1,
            // ),
            ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Customer Reviews',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  )),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Row(children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        )
                      ]),
                    );
                  })
            ]));
  }
}
