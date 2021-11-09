import 'package:emarting/Providers/comments.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
    final comments = Provider.of<Comments>(context).comments;
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 16),
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
              SizedBox(height: 10),
              Container(
                child: NotificationListener<ScrollNotification>(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Row(children: [
                            Card(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        child: CircleAvatar(
                                          radius: 15,
                                          child: Text(
                                            comments[index].userName[0],
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          backgroundColor: Colors.grey,
                                          foregroundColor: Colors.white,
                                        ),
                                      ),
                                      Text(comments[index].userName,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal)),
                                    ]),
                                    Container(
                                      padding: const EdgeInsets.all(7),
                                      child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            RatingBar.builder(
                                              ignoreGestures: true,
                                              initialRating: comments[index]
                                                  .rating
                                                  .ceil()
                                                  .toDouble(),
                                              // comments[index].rating.toDouble(),
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemSize: 20,
                                              itemCount: 5,
                                              itemPadding: EdgeInsets.symmetric(
                                                  horizontal: 1.0),
                                              itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (rating) {
                                                print(rating);
                                              },
                                            ),
                                            // Expanded(
                                            //   child: Container(
                                            //     padding: EdgeInsets.symmetric(
                                            //         horizontal: 10),
                                            //     child: Text(
                                            //       comments[index].heading,
                                            //       style: TextStyle(
                                            //         fontSize: 15,
                                            //         fontWeight: FontWeight.bold,
                                            //       ),
                                            //     ),
                                            //   ),
                                            // ),
                                          ]),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Text(
                                        comments[index].heading,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Text(
                                        comments[index].desc,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ]),
                        );
                      }),
                ),
              ),
              // Container(
              //   padding: const EdgeInsets.symmetric(vertical: 140),
              //   child: Center(
              //     child: Column(
              //       children: [
              //         SpinKitPouringHourGlassRefined(
              //           color: Colors.blue,
              //           size: 50.0,
              //         ),
              //         Text('Loading Comments!'),
              //       ],
              //     ),
              //   ),
              // ),
            ]));
  }
}
