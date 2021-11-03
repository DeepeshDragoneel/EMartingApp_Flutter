import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/product.dart';

class ShopProductTile extends StatelessWidget {
  // const ShopProductTile({ Key? key }) : super(key: key);

  // final String imageURL;
  // final String name;
  // final String desc;
  // final String id;
  final int idx;

  // ShopProductTile(this.id, this.name, this.desc, this.imageURL);
  ShopProductTile(this.idx);

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
            ])),
            Container(
              decoration: BoxDecoration(
                  // border: Border.all(color: Colors.black),
                  ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    (productInfo.name.length > 15
                        ? productInfo.name.substring(0, 15) + '...'
                        : productInfo.name),
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.body2,
                  ),
                  Consumer<Product>(
                    builder: (context, product, child) => Container(
                        // decoration: BoxDecoration(
                        //   border: Border.all(color: Colors.blue, width: 4),
                        //   color: Colors.yellow,
                        //   shape: BoxShape.circle,
                        // ),
                        child: IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      onPressed: () {
                        productInfo.changeFav();
                      },
                      icon: Icon(
                          productInfo.isFav
                              ? (Icons.favorite)
                              : (Icons.favorite_border),
                          color: (productInfo.isFav
                              ? (Colors.red)
                              : (Colors.black))),
                    )),
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
