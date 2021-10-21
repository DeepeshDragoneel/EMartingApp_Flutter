import 'package:flutter/material.dart';

class ShopProductTile extends StatelessWidget {
  // const ShopProductTile({ Key? key }) : super(key: key);

  final String imageURL;
  final String name;
  final String desc;
  final String id;

  ShopProductTile(this.id, this.name, this.desc, this.imageURL);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1, color: Colors.grey),
          bottom: BorderSide(width: 1, color: Colors.grey),
          right: BorderSide(width: 0.5, color: Colors.grey),
          left: BorderSide(width: 0.5, color: Colors.grey),
        ),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
            child: Container(
          // child: Image.network(
          //   imageURL,
          //   fit: BoxFit.fill,
          // ),
          decoration: BoxDecoration(
            color: Colors.black,
            // border: Border.all(color: Colors.black),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(imageURL),
            ),
          ),
        )),
        Container(
          decoration: BoxDecoration(
            // border: Border.all(color: Colors.black),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.body2,
              ),
              Container(
                  // decoration: BoxDecoration(
                  //   border: Border.all(color: Colors.blue, width: 4),
                  //   color: Colors.yellow,
                  //   shape: BoxShape.circle,
                  // ),
                  child: IconButton(
                onPressed: null,
                icon: Icon(Icons.favorite_border),
              )),
            ],
          ),
        )
      ]),
    );
  }
}
