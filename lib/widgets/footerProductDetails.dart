import 'package:flutter/material.dart';

class FooterProductDetails extends StatelessWidget {
  const FooterProductDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: Container(
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                    side: BorderSide(color: Colors.black))),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.favorite_outline_sharp,
                    color: Colors.black, size: 20),
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: Text('Favorite',
                      style: TextStyle(color: Colors.black, fontSize: 20)),
                ),
              ],
            )),
      )),
      Expanded(
          child: Container(
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                  side: BorderSide(color: Colors.black12),
                )),
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_bag_outlined,
                    color: Colors.white, size: 20),
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: Text('Add to Bag',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
              ],
            )),
      )),
    ]);
  }
}
