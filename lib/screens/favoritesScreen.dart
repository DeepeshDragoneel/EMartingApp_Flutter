import 'package:emarting/Providers/products.dart';
import 'package:emarting/widgets/shopProductTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  // const FavoritesScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favProducts = Provider.of<Products>(context).getFavProducts();
    return Scaffold(
        appBar: AppBar(
          title: Text('Favorites'),
          // backgroundColor: Colors.white,
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: (favProducts.length == 0
              ? Container(
                  width: double.infinity,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Text(
                            "No Favorites ❤️️!",
                            style: Theme.of(context).textTheme.title,
                          ),
                        ),
                        Box(
                          child: Text(
                            'Checkout the Items and Get it love with them..............................................',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        )
                      ]),
                )
              : (GridView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: favProducts.length,
                  itemBuilder: (context, index) {
                    return ChangeNotifierProvider.value(
                        // create: (context) => shopProducts[index],
                        value: favProducts[index],
                        child: ShopProductTile(
                            // shopProducts[index].id,
                            // shopProducts[index].name,
                            // shopProducts[index].desc,
                            // shopProducts[index].imageURL),
                            ));
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.75,
                  ),
                ))),
        ));
  }
}
