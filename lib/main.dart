import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Map<int, Color> color = {
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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF2196F3, color),
        accentColor: Color.fromRGBO(241, 227, 125, 1),
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
      ),
      home: MyHomePage(title: 'EMarting'),
    );
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
