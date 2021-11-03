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
  ScrollController? _controller;
  bool instantiatedGetProducts = false;
  bool pageLoading = true;
  int remainingProducts = 0;

  @override
  void initState() {
    // Provider.of<Products>(context).getAndSetProducts();
    _controller = new ScrollController()
      ..addListener(_handleScrollNotification);
    super.initState();
  }

  void _handleScrollNotification() {
    if (_controller?.position.extentAfter == 0 &&
        !instantiatedGetProducts &&
        remainingProducts > 0) {
      // print('loading!');
      setState(() {
        pageLoading = true;
      });
      instantiatedGetProducts = true;
      // isLoading = true;
      Provider.of<Products>(context, listen: false)
          .getAndSetProducts()
          .then((value) {
        instantiatedGetProducts = false;
        setState(() {
          pageLoading = false;
        });
      });
    }
  }

  @override
  void didChangeDependencies() {
    if (!isInit) {
      Provider.of<Products>(context)
          .getAndSetProducts()
          .then((value) => setState(() {
                pageLoading = false;
              }));
      isInit = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = Provider.of<Products>(context).isLoading;
    final productData = Provider.of<Products>(context);
    final shopProducts = productData.products;
    remainingProducts = Provider.of<Products>(context).remainingProducts;
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
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Container(
              // height: shopProducts.length > 100
              //     ? MediaQuery.of(context).size.height
              //     : 0,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: NotificationListener<ScrollNotification>(
                // onNotification: _handleScrollNotification,
                child: GridView.builder(
                  shrinkWrap: true,
                  controller: _controller,
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
            ),
          ),
          pageLoading
              ? Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.white,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Container(),
        ],
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
