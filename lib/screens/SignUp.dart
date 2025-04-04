import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmacy_management/screens/SignIn.dart';
import 'dart:io';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final ImagePicker _picker = ImagePicker();
  String? _licenseFilePath;
  final TextEditingController _licenseController = TextEditingController();

  Future<void> _browseFile() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );
      
      if (pickedFile != null) {
        setState(() {
          _licenseFilePath = pickedFile.path;
          _licenseController.text = pickedFile.name;
        });
      }
    } catch (e) {
      print("Error picking image: $e");
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Top Blue Header with Logo
          Container(
            height: 180,
            decoration: BoxDecoration(
              color: Color(0xFF2D5FFF),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Center(
              child: Image.asset(
                'assets/Logo.png',
                height: 100,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInputField(Icons.local_hospital, "Hospital Name"),
                  buildInputField(Icons.email, "Hospital Email"),
                  buildInputField(Icons.phone, "Contact"),
                  buildInputField(Icons.location_on, "Address"),
                  buildLicenseField(),
                  buildInputField(Icons.lock, "Password", isPassword: true),
                  SizedBox(height: 20),

                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignInScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF2D5FFF),
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: Text(
                        "Sign up",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),

                  SizedBox(height: 15),

                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already Have An Account? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignInScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInputField(IconData icon, String label, {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.black54),
          labelText: label,
          labelStyle: TextStyle(color: Colors.black),
          border: UnderlineInputBorder(),
          suffixIcon: isPassword ? Icon(Icons.visibility_off) : null,
        ),
      ),
    );
  }

  Widget buildLicenseField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Stack(
        children: [
          TextField(
            controller: _licenseController,
            readOnly: true,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.file_upload, color: Colors.black54),
              labelText: "Medical License",
              labelStyle: TextStyle(color: Colors.black),
              border: UnderlineInputBorder(),
              hintText: "Browse to select file",
              suffixIcon: IconButton(
                icon: Icon(Icons.folder_open, color: Colors.black54),
                onPressed: _browseFile,
              ),
            ),
          ),
          // This transparent container makes the entire field clickable
          Positioned.fill(
            child: GestureDetector(
              onTap: _browseFile,
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}