import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Hello Friend!'),
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
