import 'package:flutter/material.dart';
import 'package:pharmacy_management/screens/SignUp.dart';

class LendingScreen extends StatefulWidget {
  @override
  _LendingScreenState createState() => _LendingScreenState();
}

class _LendingScreenState extends State<LendingScreen> {
  @override
  void initState() {
    super.initState();
    print("LendingScreen: initState called, starting delay...");

    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        print("LendingScreen: Redirecting to SignUpScreen...");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignUpScreen()),
        );
      } else {
        print("LendingScreen: Widget is no longer mounted.");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/Lending.png',
              width: 250,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.error, color: Colors.red);
              },
            ),
            SizedBox(height: 20),
            Text(
              "View and buy\nMedicine online",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            SizedBox(height: 10),
            Text(
              "Etiam mollis metus non purus faucibus sollicitudin.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            SizedBox(height: 30),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
