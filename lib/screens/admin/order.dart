import 'package:pharmacy_management/screens/admin/cart.dart';
import 'package:flutter/material.dart';

class Order {
  final String orderId;
  final String hospitalName;
  final String hospitalLogo;
  final String productName;
  final String productImage;
  final String productId;
  final double productPrice;
  final int quantity;
  final String address;

  Order({
    required this.orderId,
    required this.hospitalName,
    required this.hospitalLogo,
    required this.productName,
    required this.productImage,
    required this.productId,
    required this.productPrice,
    required this.quantity,
    required this.address,
  });
}

class OrdersPage extends StatefulWidget {
  final String hospitalName;

  const OrdersPage({
    Key? key,
    required this.hospitalName,
  }) : super(key: key);

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  // Sample data - in a real app, this would come from an API or database
  final Map<String, List<Order>> hospitalOrders = {
    'HGC Hospital': [
      Order(
        orderId: '102',
        hospitalName: 'HGC Hospital',
        hospitalLogo: 'assets/hgc.jpg',
        productName: 'Timolet',
        productImage: 'assets/timolet.jpeg',
        productId: 'Ord101',
        productPrice: 80,
        quantity: 90,
        address: 'Yagnik Road, Rajkot 360004',
      ),
      Order(
        orderId: '102',
        hospitalName: 'HGC Hospital',
        hospitalLogo: 'assets/hgc.jpg',
        productName: 'Latanoprost',
        productImage: 'assets/latanoprost.jpg',
        productId: 'Ord102',
        productPrice: 112,
        quantity: 90,
        address: 'Yagnik Road, Rajkot 360004',
      ),
    ],
    'Synergy Hospital': [
      Order(
        orderId: '103',
        hospitalName: 'Synergy Hospital',
        hospitalLogo: 'assets/synergy.jpg',
        productName: 'Aspirin',
        productImage: 'assets/aspirin.jpg',
        productId: 'Ord103',
        productPrice: 25,
        quantity: 50,
        address: 'Kalavad Road, Rajkot 360005',
      ),
    ],
  };

  @override
  Widget build(BuildContext context) {
    final orders = hospitalOrders[widget.hospitalName];
    
    if (orders == null || orders.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('No Orders Found'),
          backgroundColor: const Color(0xFF4169FF),
        ),
        body: const Center(
          child: Text('No orders found for this hospital.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'MediCare',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              'Orders Of ${widget.hospitalName}',
              style: const TextStyle(
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
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return OrderCard(order: orders[index]);
        },
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({
    Key? key,
    required this.order,
  }) : super(key: key);

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
                      fit: BoxFit.cover,
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
            // Product details with image
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.asset(
                    order.productImage,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.medication,
                        color: Colors.blue,
                        size: 50,
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          "Product Name: ${order.productName}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          "Product Id: ${order.productId}",
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          "Product Price: ${order.productPrice.toInt()}",
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          "Quantity: ${order.quantity}",
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            // Order details
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                "Order Id: ${order.orderId}",
                style: const TextStyle(fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                "Address: ${order.address}",
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AllUsersPage extends StatelessWidget {
  const AllUsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample list of hospitals
    final List<String> hospitals = ['HGC Hospital', 'Synergy Hospital'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Hospitals'),
        backgroundColor: const Color(0xFF4169FF),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: hospitals.length,
        itemBuilder: (context, index) {
          final hospitalName = hospitals[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(
                hospitalName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.list_alt, color: Color(0xFF4169FF)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrdersPage(
                            hospitalName: hospitalName,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}