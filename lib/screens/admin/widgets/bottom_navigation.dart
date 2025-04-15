import 'package:flutter/material.dart';
import 'package:pharmacy_management/screens/admin/admin_dashboard.dart';
import 'package:pharmacy_management/screens/admin/all_users.dart';
import 'package:pharmacy_management/screens/admin/all_orders.dart';
import 'package:pharmacy_management/screens/admin/view_category.dart';
import 'package:pharmacy_management/screens/admin/view_products.dart';



class MediCareBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const MediCareBottomNavigation({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => _handleNavigation(context, index),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Color(0xFF2D5FFF),
      unselectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'Categories'),
        BottomNavigationBarItem(icon: Icon(Icons.inventory), label: 'Medicines'),
        BottomNavigationBarItem(icon: Icon(Icons.insert_chart), label: 'All Orders'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'All Users'),
      ],
    );
  }

  void _handleNavigation(BuildContext context, int index) {
    // Don't navigate if we're already on the selected page
    if (index == currentIndex) return;
    
    // Call the onTap callback to update the parent's state
    onTap(index);
    
    // Handle navigation based on index
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/dashboard');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/viewCategories');
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
}