import 'dart:async';

import 'package:flutter/material.dart';
import 'package:task3/color.dart';
import 'package:task3/screen/splashscreen.dart';
import 'package:task3/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const SplashScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: CustomColor.blue,
        child: FlutterLogo(size: MediaQuery.of(context).size.height));
  }
}
