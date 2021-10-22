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
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: Colors.grey),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
                child: Stack(children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  // border: Border.all(color: Colors.black),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(imageURL),
                  ),
                ),
              ),
              new Positioned.fill(
                  child: new Material(
                      color: Colors.transparent,
                      child: new InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed('/productDetails',
                              arguments: this.id);
                        },
                      ))),
            ])),
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
        ),
      ),
    );
  }
}
