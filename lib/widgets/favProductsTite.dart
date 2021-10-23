import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/product.dart';

class FavProductsTile extends StatelessWidget {
  // const FavProductsTile({ Key? key }) : super(key: key);

  // final String imageURL;
  // final String name;
  // final String desc;
  // final String id;
  final Function removeFavProduct;
  FavProductsTile(this.removeFavProduct);

  // FavProductsTile(this.id, this.name, this.desc, this.imageURL);

  @override
  Widget build(BuildContext context) {
    final productInfo = Provider.of<Product>(context, listen: false);
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
                    image: NetworkImage(productInfo.imageURL),
                  ),
                ),
              ),
              new Positioned.fill(
                  child: new Material(
                      color: Colors.transparent,
                      child: new InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed('/productDetails',
                              arguments: productInfo.id);
                        },
                      ))),
              Positioned(
                  right: -2,
                  top: -9,
                  child: IconButton(
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.blueGrey.withOpacity(0.5),
                        size: 20,
                      ),
                      onPressed: () {
                        removeFavProduct(productInfo.id);
                      })),
            ])),
            Container(
              decoration: BoxDecoration(
                  // border: Border.all(color: Colors.black),
                  ),
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    productInfo.name,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.body2,
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
