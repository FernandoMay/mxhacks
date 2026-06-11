import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mxhck/home.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => Home()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrangeAccent,
      body: Center(
        child: Text(
          'pastillaMe',
          style: TextStyle(fontSize: 38.0, color: Colors.white),
        ),
      ),
    );
  }
}
