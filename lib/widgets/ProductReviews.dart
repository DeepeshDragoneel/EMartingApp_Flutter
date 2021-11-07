import 'package:flutter/material.dart';

class ProductReviews extends StatelessWidget {
  const ProductReviews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey[300] as Color,
          width: 1,
        ),
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
          ]),
    );
  }
}
