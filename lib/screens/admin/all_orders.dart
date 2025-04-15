import 'package:flutter/material.dart';
import 'package:pharmacy_management/screens/admin/widgets/bottom_navigation.dart';

class Order {
  final String hospitalName;
  final String hospitalLogo;
  final String productName;
  final String productId;
  final double productPrice;
  final int quantity;
  final String address;
  final String productImage;

  Order({
    required this.hospitalName,
    required this.hospitalLogo,
    required this.productName,
    required this.productId,
    required this.productPrice,
    required this.quantity,
    required this.address,
    required this.productImage,
  });
}

class AllOrdersPage extends StatefulWidget {
  const AllOrdersPage({Key? key}) : super(key: key);

  @override
  _AllOrdersPageState createState() => _AllOrdersPageState();
}

class _AllOrdersPageState extends State<AllOrdersPage> {
  int _currentIndex = 3; // Since "All Orders" is the 4th item (index 3)

  // Sample data - in a real app, this would come from an API or database
  final List<Order> orders = [
    Order(
      hospitalName: 'HGC Hospital',
      hospitalLogo: 'assets/hgc.jpg',
      productName: 'Timolet',
      productId: 'Ord101',
      productPrice: 80,
      quantity: 90,
      address: 'Yagnik Road, Rajkot 360004',
      productImage: 'assets/timolet.jpeg',
    ),
    Order(
      hospitalName: 'Synergy Hospital',
      hospitalLogo: 'assets/synergy.jpg',
      productName: 'Latanoprost',
      productId: 'Ord102',
      productPrice: 112,
      quantity: 90,
      address: 'Yagnik Road, Rajkot 360004',
      productImage: 'assets/latanoprost.jpg',
    ),
    // Add more orders as needed
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    // Navigation is now handled in the MediCareBottomNavigation widget
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/dashboard');
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
              'All Orders',
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
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return OrderCard(order: orders[index]);
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

class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({Key? key, required this.order}) : super(key: key);

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
                      order.hospitalLogo,
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
                        "Hospital's Name: ${order.hospitalName}",
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
            // Product information row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.asset(
                    order.productImage,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.medication,
                        color: Colors.blue,
                        size: 40,
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Product Name: ${order.productName}",
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      Text("Product Id: ${order.productId}"),
                      const SizedBox(height: 8),
                      Text("Product Price: ${order.productPrice}"),
                      const SizedBox(height: 8),
                      Text("Quantity: ${order.quantity}"),
                      const SizedBox(height: 8),
                      Text("Address: ${order.address}"),
                    ],
                  ),
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
        '/': (context) => const AllOrdersPage(),
        '/dashboard': (context) => const Placeholder(), 
        '/viewCategories': (context) => const Placeholder(), 
        '/viewProducts': (context) => const Placeholder(), 
        '/allusers': (context) => const Placeholder(),
      },
      home: const AllOrdersPage(),
    );
  }
}