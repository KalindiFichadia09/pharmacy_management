import 'package:flutter/material.dart';
import 'package:pharmacy_management/screens/admin/widgets/bottom_navigation.dart';
import 'package:pharmacy_management/screens/admin/edit_categories.dart'; 

class ViewCategoriesPage extends StatefulWidget {
  @override
  _ViewCategoriesPageState createState() => _ViewCategoriesPageState();
}

class _ViewCategoriesPageState extends State<ViewCategoriesPage> {
  // Sample category data
  List<Map<String, String>> categories = [
    {"name": "Eyes", "image": "assets/eyes.jpg"},
    {"name": "Ears", "image": "assets/ears.jpg"},
    {"name": "Skin Care", "image": "assets/skincare.jpg"},
    {"name": "Digestive System", "image": "assets/degistive.jpg"},
  ];
  
  int _selectedIndex = 1; // Set to Categories tab

  void _onTabTapped(int index) {
    if (index == _selectedIndex && index != 1) return; // Avoid unnecessary navigation
    
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/dashboard');
        break;
      case 1:
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/viewProducts');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/allorders');
        break;
      case 4:
        Navigator.pushReplacementNamed(context, '/allusers');
        break;
    }
  }

  Future<void> _editCategory(int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditCategoryPage(categoryData: categories[index]),
      ),
    );
    
    if (result != null && result is Map<String, String>) {
      setState(() {
        categories[index] = result;
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
            Navigator.pushReplacementNamed(context, '/viewCategories');
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
              'All Categories',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 3,
              margin: EdgeInsets.only(bottom: 12),
              child: ListTile(
                contentPadding: EdgeInsets.all(10),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    category["image"]!,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image, size: 80),
                  ),
                ),
                title: Text(
                  "Category Name: ${category['name']}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        // Handle delete
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.green),
                      onPressed: () {
                        _editCategory(index);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF2D5FFF),
        onPressed: () {
          Navigator.pushNamed(context, '/addCategory');
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: MediCareBottomNavigation(
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}