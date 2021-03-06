import 'package:emarting/Providers/auth.dart';
import 'package:emarting/Providers/cart.dart';
import 'package:emarting/Providers/comments.dart';
import 'package:emarting/Providers/orders.dart';
import 'package:emarting/screens/addReviewScreen.dart';
import 'package:emarting/screens/authScreen.dart';
import 'package:emarting/screens/cartScreen.dart';
import 'package:emarting/screens/editProductScreen.dart';
import 'package:emarting/screens/favoritesScreen.dart';
import 'package:emarting/screens/homeControllerScreen.dart';
import 'package:emarting/screens/myProductScreen.dart';
import 'package:emarting/screens/ordersScreen.dart';
import 'package:emarting/screens/productDetailsScreen.dart';
import 'package:emarting/screens/shopMainScreen.dart';
import 'package:flutter/material.dart';
import './Providers/products.dart';
import 'package:provider/provider.dart';
import 'package:flutter_config/flutter_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Map<int, Color> color = {
    50: Color.fromRGBO(85, 246, 240, .1),
    100: Color.fromRGBO(85, 246, 240, .2),
    200: Color.fromRGBO(85, 246, 240, .3),
    300: Color.fromRGBO(85, 246, 240, .4),
    400: Color.fromRGBO(85, 246, 240, .5),
    500: Color.fromRGBO(85, 246, 240, .6),
    600: Color.fromRGBO(85, 246, 240, .7),
    700: Color.fromRGBO(85, 246, 240, .8),
    800: Color.fromRGBO(85, 246, 240, .9),
    900: Color.fromRGBO(85, 246, 240, 1),
  };

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => Auth()),
          ChangeNotifierProvider(create: (context) => Products()),
          ChangeNotifierProvider(create: (context) => CartItems()),
          ChangeNotifierProvider(create: (context) => Orders()),
          ChangeNotifierProvider(create: (context) => Comments()),
        ],
        child: Consumer<Auth>(
          builder: (context, authData, _) {
            return MaterialApp(
              title: 'EMarting',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: MaterialColor(0xFF2196F3, color),
                accentColor: Color.fromRGBO(241, 227, 125, 1),
                canvasColor: Color.fromRGBO(255, 254, 229, 1),
                fontFamily: 'Ubuntu',
                textTheme: ThemeData.light().textTheme.copyWith(
                    body1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                    body2: TextStyle(
                        color: Color.fromRGBO(20, 51, 51, 1),
                        fontWeight: FontWeight.bold),
                    title: TextStyle(
                      fontSize: 24.5,
                      fontFamily: 'RobotoCondensed',
                      fontWeight: FontWeight.bold,
                    )),
              ),
              home: HomeControllerScreen(),
              routes: {
                '/shop': (context) => ShopMainScreen(),
                '/auth': (context) => AuthScreen(),
                '/productDetails': (context) => ProductDetailesScreen(),
                '/addReview': (context) => AddReviewScreen(),
                '/favoriteProducts': (context) => FavoritesScreen(),
                '/cart': (context) => CartScreen(),
                '/orders': (context) => OrderScreen(),
                '/myProducts': (context) => MyProductScreen(),
                '/editProduct': (context) => EditProductScreen(),
              },
            );
          },
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'EMarting',
            ),
          ],
        ),
      ),
    );
  }
}
