import 'package:flutter/material.dart';

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
      onTap: onTap,
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
}