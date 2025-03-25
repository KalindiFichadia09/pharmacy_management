import 'package:flutter/material.dart';
import 'screens/Splash.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MediCare',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(), 
    );
  }
}
