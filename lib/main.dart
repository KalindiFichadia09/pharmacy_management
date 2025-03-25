import 'package:flutter/material.dart';
import 'package:pharmacy_management/screens/splashScreen.dart';

main() => runApp(
      mediCare(),
    );

class mediCare extends StatelessWidget {
  const mediCare({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: splashScreen(),
    );
  }
}
