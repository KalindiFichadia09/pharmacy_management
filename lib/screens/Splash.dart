import 'package:flutter/material.dart';
import 'dart:async';
import 'Lending.dart'; // Import the Lending screen

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LendingScreen())); // Navigate to Lending
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/Splash.png', fit: BoxFit.cover),
          Center(
            child: Image.asset('assets/logo.png', width: 500, height: 500),
          ),
        ],
      ),
    );
  }
}
