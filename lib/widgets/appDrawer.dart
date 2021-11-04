import 'package:emarting/Providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String userName = 'Friend';

  @override
  void didChangeDependencies() {
    userName = Provider.of<Auth>(context).userName;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Hello ${userName}!'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.home_filled),
            title: Text("Shop"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          ListTile(
            leading: Icon(Icons.payment_outlined),
            title: Text("Orders"),
            onTap: () {
              Navigator.of(context).pushNamed('/orders');
            },
          ),
          ListTile(
            leading: Icon(Icons.inventory_2_outlined),
            title: Text("My Products"),
            onTap: () {
              Navigator.of(context).pushNamed('/myProducts');
            },
          ),
        ],
      ),
    );
  }
}
