import 'dart:async';

import 'package:flutter/material.dart';
import 'package:task3/color.dart';
import 'package:task3/screen/loginscreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: CustomColor.blue,
        child: const Center(
          child: Text(
            'Task 3',
            style: TextStyle(
              fontSize: 40,
              color: Colors.white
            ),
          ),
        ),
      ),
    );
  }
}