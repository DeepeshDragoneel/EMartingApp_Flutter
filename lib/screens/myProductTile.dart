import 'package:flutter/material.dart';

class MyProductTile extends StatelessWidget {
  // const MyProductTile({ Key? key }) : super(key: key);

  final String id;
  final String name;
  final String imageURL;

  MyProductTile(this.id, this.name, this.imageURL);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(name),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageURL),
        ),
        trailing: Container(
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed('/editProduct', arguments: id);
                  },
                  icon: Icon(Icons.edit, color: Colors.blue)),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  )),
            ],
          ),
        ));
  }
}
