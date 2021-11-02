import 'package:emarting/Providers/cart.dart';
import 'package:emarting/screens/favoritesScreen.dart';
import 'package:emarting/widgets/appDrawer.dart';
import 'package:emarting/widgets/badge.dart';
import 'package:emarting/widgets/shopProductTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/product.dart';
import '../Providers/products.dart';

class ShopMainScreen extends StatefulWidget {
  // const ShopMainScreen({ Key? key }) : super(key: key);

  @override
  _ShopMainScreenState createState() => _ShopMainScreenState();
}

class _ShopMainScreenState extends State<ShopMainScreen> {
  bool isInit = false;

  @override
  void initState() {
    // Provider.of<Products>(context).getAndSetProducts();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!isInit) {
      Provider.of<Products>(context).getAndSetProducts();
      isInit = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final shopProducts = productData.products;
    return Scaffold(
      appBar: AppBar(
        title: Text("EMarting"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/favoriteProducts');
            },
            icon: Icon(Icons.favorite_outline_sharp, color: Colors.white),
            color: Colors.red,
          ),
          Consumer<CartItems>(
            builder: (context, cartData, child) {
              return Badge(
                  child: child as Widget,
                  value: cartData.cartItemsLength.toString());
            },
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/cart');
                },
                icon: Icon(Icons.shopping_bag_outlined)),
          ),
        ],
        // backgroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: GridView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: shopProducts.length,
          itemBuilder: (context, index) {
            return ChangeNotifierProvider.value(
                // create: (context) => shopProducts[index],
                value: shopProducts[index],
                child: ShopProductTile(
                  index,
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
        ),
      ),
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor:
              Colors.white, //This will change the drawer background to blue.
          //other styles
        ),
        child: AppDrawer(),
      ),
    );
  }
}
