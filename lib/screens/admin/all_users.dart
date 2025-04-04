//import 'package:admin/screens/all_orders.dart';
import 'package:flutter/material.dart';
import 'package:pharmacy_management/screens/admin/widgets/bottom_navigation.dart';
import 'package:pharmacy_management/screens/admin/wishlist.dart';
import 'package:pharmacy_management/screens/admin/cart.dart'; 
import 'package:pharmacy_management/screens/admin/order.dart';

class Hospital {
  final String name;
  final String logo;
  final String email;
  final String phoneNumber;
  final String address;
  final String status;

  Hospital({
    required this.name,
    required this.logo,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.status,
  });
}

class AllUsersPage extends StatefulWidget {
  const AllUsersPage({Key? key}) : super(key: key);

  @override
  _AllUsersPageState createState() => _AllUsersPageState();
}

class _AllUsersPageState extends State<AllUsersPage> {
  int _currentIndex = 4; // Since "All Users" is the 5th item (index 4)

  // Sample data - in a real app, this would come from an API or database
  final List<Hospital> hospitals = [
    Hospital(
      name: 'HGC Hospital',
      logo: 'assets/hgc.jpg',
      email: 'hgc@gmail.com',
      phoneNumber: '9875639745',
      address: 'Yagnik Road, Rajkot 360004',
      status: 'Approved',
    ),
    Hospital(
      name: 'Synergy Hospital',
      logo: 'assets/synergy.jpg',
      email: 'hgc@gmail.com', // This appears to be the same in the screenshot
      phoneNumber: '9875639745',
      address: 'Yagnik Road, Rajkot 360004',
      status: 'Waiting',
    ),
    // Add more hospitals as needed
  ];

  void _onTabTapped(int index) {
    // Don't return early, always allow navigation
    setState(() {
      _currentIndex = index;
    });

    // Use Navigator.pushNamed instead of pushReplacementNamed to preserve navigation stack
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/dashboard');
        break;
      case 1:
        Navigator.pushNamed(context, '/viewCategories');
        break;
      case 2:
        Navigator.pushNamed(context, '/viewProducts');
        break;
      case 3:
        Navigator.pushNamed(context, '/allOrders');
        break;
      case 4:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushNamed(context, '/dashboard');
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'MediCare',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              'All Users',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF4169FF),
        elevation: 0,
        actions: [
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: hospitals.length,
              itemBuilder: (context, index) {
                return HospitalCard(hospital: hospitals[index]);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: MediCareBottomNavigation(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}

class HospitalCard extends StatelessWidget {
  final Hospital hospital;

  const HospitalCard({Key? key, required this.hospital}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hospital information row
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                    child: Image.asset(
                      hospital.logo,
                      width: 50,
                      height: 50,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.local_hospital,
                          color: Colors.blue, 
                          size: 30,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hospital's Name: ${hospital.name}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 32),
            // Hospital details
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                "Hospital's Email: ${hospital.email}",
                style: const TextStyle(fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                "Phone.No: ${hospital.phoneNumber}",
                style: const TextStyle(fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                "Hospital's Address: ${hospital.address}",
                style: const TextStyle(fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  const Text(
                    "License: ",
                    style: TextStyle(fontSize: 14),
                  ),
                  TextButton(
                    onPressed: () {
                      // Handle license view action
                    },
                    child: const Text(
                      "See License",
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  const Text(
                    "Status: ",
                    style: TextStyle(fontSize: 14),
                  ),
                  Text(
                    hospital.status,
                    style: TextStyle(
                      color: hospital.status == 'Approved' ? Colors.green : Colors.orange,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Action icons
            Row(
              children: [
                // Modified shopping cart icon with navigation
                IconButton(
                  icon: const Icon(Icons.shopping_cart, color: Colors.grey),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HospitalCartPage(hospitalName: hospital.name),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.favorite_border, color: Colors.grey),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HospitalWishlistPage(hospitalName: hospital.name),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.local_shipping_outlined, color: Colors.grey),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrdersPage(
                          hospitalName: hospital.name,
                        ),
                      ),
                    );
                  },
                ),
                const Spacer(),
                if (hospital.status == 'Waiting')
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.check_circle, color: Colors.green),
                        onPressed: () {
                          // Handle approve action
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.cancel, color: Colors.red),
                        onPressed: () {
                          // Handle reject action
                        },
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Main entry point for testing
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediCare',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF4169FF),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': (context) => const AllUsersPage(),
        '/dashboard': (context) => const Placeholder(),
        '/viewCategories': (context) => const Placeholder(),
        '/viewProducts': (context) => const Placeholder(),
        '/allOrders': (context) => const Placeholder(),
      },
      home: const AllUsersPage(),
    );
  }
}