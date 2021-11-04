import 'package:emarting/Providers/auth.dart';
import 'package:emarting/screens/authScreen.dart';
import 'package:emarting/screens/shopMainScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeControllerScreen extends StatefulWidget {
  const HomeControllerScreen({Key? key}) : super(key: key);

  @override
  _HomeControllerScreenState createState() => _HomeControllerScreenState();
}

class _HomeControllerScreenState extends State<HomeControllerScreen> {
  final homeScreens = [AuthScreen(), ShopMainScreen()];
  bool init = false;
  bool isAuth = false;
  bool loadingHomePage = false;

  @override
  void didChangeDependencies() async {
    if (!init) {
      setState(() {
        loadingHomePage = true;
      });
      final temp = await Provider.of<Auth>(context).isAuthenticated;
      setState(() {
        isAuth = temp;
        loadingHomePage = false;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return loadingHomePage
        ? CircularProgressIndicator()
        : !isAuth
            ? AuthScreen()
            : ShopMainScreen();
  }
}
