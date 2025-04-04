import 'package:flutter/material.dart';
import 'package:pharmacy_management/screens/Dashboard.dart';
import 'package:pharmacy_management/screens/Cart.dart';
import 'package:pharmacy_management/screens/Expore.dart';
import 'package:pharmacy_management/screens/Wishlist.dart';
import 'package:pharmacy_management/screens/Profile.dart'; // Ensure this import exists

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({Key? key, required this.currentIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: const Color(0xFF2D5FFF),
      unselectedItemColor: const Color(0xFF85939B),
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed, // Ensures all labels are always visible
      onTap: (index) {
        if (index == currentIndex) return;

        Widget screen;
        switch (index) {
          case 0:
            screen =  DashboardScreen();
            break;
          case 1:
            screen = const WishlistScreen();
            break;
          case 2:
            screen = const ExploreScreen();
            break;
          case 3:
            screen = const CartScreen();
            break;
          case 4:
            screen =  ProfileScreen();
            break;
          default:
            screen =  DashboardScreen();
        }

        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorites"),
        BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Explore"),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    );
  }
}