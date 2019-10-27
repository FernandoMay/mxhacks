import 'package:splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:mxhck/home.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 1,
      navigateAfterSeconds: Home(),
      //image: Image.asset('lib/assets/zulogo.png'),
      backgroundColor: Colors.deepOrangeAccent,
      //photoSize: 110,
      //loaderColor: Colors.transparent,
      title: Text('pastillaMe'),
    );
  }
}