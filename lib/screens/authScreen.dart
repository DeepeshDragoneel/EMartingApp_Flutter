import 'package:emarting/widgets/authCard.dart';
import 'package:flutter/material.dart';
import 'dart:math';

enum AuthMode {
  Signup,
  Login,
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        // reverse: true,
        physics: ClampingScrollPhysics(),
        child: Stack(alignment: Alignment.center, children: <Widget>[
          Container(
            height: deviceSize.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/homePageBackground.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Container(
          //   height: 100,
          //   width:100,
          //   decoration: BoxDecoration(
          //     image: DecorationImage(
          //       image: AssetImage('assets/images/icon.png'),
          //       fit: BoxFit.cover,
          //     ),
          //   )
          // ),
          Container(
            height: deviceSize.height,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    transform: Matrix4.translationValues(0.0, -60.0, 0.0),
                    // height: deviceSize.height,
                    // decoration: BoxDecoration(
                        // color: Colors.white,
                        // border: Border.all(color: Colors.white)),
                    child: Center(
                      child: Column(
                        children: [
                          Center(
                              child: Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Welcome to EMarting!',
                              style:
                                  Theme.of(context).textTheme.title!.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 35,
                                      ),
                            ),
                          )),
                          Center(
                              child: Container(
                            padding: EdgeInsets.all(7),
                            child: Text(
                              'Choose Your Favorite Books from biggest Collection!',
                              style:
                                  Theme.of(context).textTheme.body1!.copyWith(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                              textAlign: TextAlign.center,
                            ),
                          )),
                          SizedBox(
                            height: 20,
                          ),
                          AuthCard(),
                        ],
                      ),
                    ),
                  ),
                ]),
          ),
        ]),
      ),
    );
  }
}
