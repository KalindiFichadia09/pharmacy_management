import 'package:flutter/material.dart';
import 'package:pharmacy_management/screens/admin/widgets/bottom_navigation.dart';
import 'package:pharmacy_management/screens/admin/add_products.dart';
import 'package:pharmacy_management/screens/admin/edit_products.dart';

class ViewProductsPage extends StatefulWidget {
  @override
  _ViewProductsPageState createState() => _ViewProductsPageState();
}

class _ViewProductsPageState extends State<ViewProductsPage> {
  List<Map<String, dynamic>> products = [
    {
      "name": "Timolet",
      "image": "assets/timolet.jpeg",
      "price": "80",
      "category": "Eyes",
      "expiryDate": "06/07/2025",
      "details": "To treat elevated intraocular pressure...",
      "ingredients": "Active: 2.22 mg olopatadine hydrochloride..."
    },
    {
      "name": "Latanoprost",
      "image": "assets/latanoprost.jpg",
      "price": "112",
      "category": "Eyes",
      "expiryDate": "10/12/2024",
      "details": "Used to lower high pressure inside the eye...",
      "ingredients": "Latanoprost 0.005% w/v..."
    },
    {
      "name": "Aspirin",
      "image": "assets/aspirin.jpg",
      "price": "45",
      "category": "Pain Relief",
      "expiryDate": "15/08/2026",
      "details": "Used to reduce pain, fever, and inflammation...",
      "ingredients": "Active: Acetylsalicylic acid 325mg..."
    },
  ];

  int _selectedIndex = 2;

  void _onTabTapped(int index) {
    if (index == _selectedIndex && index != 2) return;

    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/dashboard');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/viewCategories');
        break;
      case 2:
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/allorders');
        break;
      case 4:
        Navigator.pushReplacementNamed(context, '/allusers');
        break;
    }
  }

  void deleteProduct(int index) {
    setState(() {
      products.removeAt(index);
    });
  }

  void editProduct(int index) async {
    final updatedProduct = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProductsPage(productData: products[index]),
      ),
    );

    if (updatedProduct != null) {
      setState(() {
        products[index] = updatedProduct as Map<String, dynamic>;
      });
    }
  }

  void addProduct() async {
    final newProduct = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddProductPage()),
    );

    if (newProduct != null) {
      setState(() {
        products.add(newProduct as Map<String, dynamic>);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xFF2D5FFF),
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'MediCare',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'All Products',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 3,
              margin: EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            product["image"]!,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.broken_image, size: 80, color: Colors.red);
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Product Name: ${product['name']}",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            deleteProduct(index);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.green),
                          onPressed: () {
                            editProduct(index);
                          },
                        ),
                      ],
                    ),
                    const Divider(height: 32),
                    Text("Product Price: ${product['price']}"),
                    Text("Category Name: ${product['category']}"),
                    Text("Medicine's Expiry Date: ${product['expiryDate']}"),
                    SizedBox(height: 5),
                    Text(
                      "Product Details: ${product['details']}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Product Ingredients: ${product['ingredients']}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addProduct,
        backgroundColor: Color(0xFF2D5FFF),
        child: Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: MediCareBottomNavigation(
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
