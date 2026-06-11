import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mxhck/splash.dart';

var firstCamera;

Future<void> main() async {
  final cameras = await availableCameras();
  firstCamera = cameras.first;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PastillaMe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFFF6D00)),
      ),
      home: Splash(),
    );
  }
}
