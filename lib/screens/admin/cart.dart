import 'package:flutter/material.dart';

class CartProduct {
  final String name;
  final String image;
  final String productId;
  final double price;
  final int quantity;

  CartProduct({
    required this.name,
    required this.image,
    required this.productId,
    required this.price,
    required this.quantity,
  });
}

class Hospital {
  final String name;
  final String logo;
  final List<CartProduct> cartProducts;

  Hospital({
    required this.name,
    required this.logo,
    required this.cartProducts,
  });
}

class HospitalCartPage extends StatefulWidget {
  final String hospitalName;

  const HospitalCartPage({
    Key? key,
    required this.hospitalName,
  }) : super(key: key);

  @override
  _HospitalCartPageState createState() => _HospitalCartPageState();
}

class _HospitalCartPageState extends State<HospitalCartPage> {
  // Sample data - in a real app, this would come from an API or database
  final Map<String, Hospital> hospitals = {
    'HGC Hospital': Hospital(
      name: 'HGC Hospital',
      logo: 'assets/hgc.jpg',
      cartProducts: [
        CartProduct(
          name: 'Timolet',
          image: 'assets/timolet.jpeg',
          productId: 'Ord101',
          price: 80,
          quantity: 90,
        ),
        CartProduct(
          name: 'Latanoprost',
          image: 'assets/latanoprost.jpg',
          productId: 'Ord102',
          price: 112,
          quantity: 90,
        ),
      ],
    ),
    'Synergy Hospital': Hospital(
      name: 'Synergy Hospital',
      logo: 'assets/synergy.jpg',
      cartProducts: [
        CartProduct(
          name: 'Aspirin',
          image: 'assets/aspirin.jpg',
          productId: 'Ord103',
          price: 25,
          quantity: 50,
        ),
      ],
    ),
  };

  @override
  Widget build(BuildContext context) {
    final hospital = hospitals[widget.hospitalName];
    
    if (hospital == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Hospital Not Found'),
          backgroundColor: const Color(0xFF4169FF),
        ),
        body: const Center(
          child: Text('Hospital not found in our records.'),
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
              'Cart Of ${hospital.name}',
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
      body: hospital.cartProducts.isEmpty
          ? const Center(
              child: Text('No products in cart'),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: hospital.cartProducts.length,
              itemBuilder: (context, index) {
                return ProductCartCard(
                  hospital: hospital,
                  product: hospital.cartProducts[index],
                );
              },
            ),
    );
  }
}

class ProductCartCard extends StatelessWidget {
  final Hospital hospital;
  final CartProduct product;

  const ProductCartCard({
    Key? key,
    required this.hospital,
    required this.product,
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
            // Product details
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
                    product.image,
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
                          "Product Name: ${product.name}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          "Product Id: ${product.productId}",
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          "Product Price: ${product.price.toInt()}",
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          "Quantity: ${product.quantity}",
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
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