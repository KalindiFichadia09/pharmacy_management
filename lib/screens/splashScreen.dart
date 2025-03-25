import 'package:flutter/material.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Color
          Container(
            color: Colors.blue, // Blue background color
          ),
          // Background Image
          Image.asset(
            'assets/splashScreenBg.png',
            fit: BoxFit.cover,
          ),
          // Centered Logo and Text
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/logo.png',
                  width: 250,
                  height: 250,
                ),
                // const SizedBox(height: 10),
                // const Text(
                //   "MediCare",
                //   style: TextStyle(
                //     fontSize: 24,
                //     fontWeight: FontWeight.bold,
                //     color: Colors.white,
                //     fontStyle: FontStyle.italic,
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
