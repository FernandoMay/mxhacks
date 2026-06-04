import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mxhck/splash.dart';

var firstCamera;

Future<void> main() async {
  final cameras = await availableCameras();
  firstCamera = cameras.first;
  runApp(MyApp());
}

bool checkedTerminos = false;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'pastillaMe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        focusColor: Colors.deepOrangeAccent, colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange).copyWith(secondary: Colors.deepOrangeAccent),
      ),
      home: Splash(),
    );
  }
}
