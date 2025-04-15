import 'package:flutter/material.dart';
import 'package:pharmacy_management/screens/admin/widgets/bottom_navigation.dart';
import 'package:pharmacy_management/screens/admin/profile.dart';

class MediCareAdminDashboard extends StatefulWidget {
  @override
  _MediCareAdminDashboardState createState() => _MediCareAdminDashboardState();
}

class _MediCareAdminDashboardState extends State<MediCareAdminDashboard> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Navigation is now handled in the MediCareBottomNavigation widget
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;

    double cardHeight = orientation == Orientation.portrait
        ? screenSize.height * 0.20
        : screenSize.height * 0.25;

    double cardWidth = screenSize.width * 0.90;
    double cardPadding = screenSize.width * 0.05;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false, 
        backgroundColor: Color(0xFF2D5FFF),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'MediCare',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Welcome Admin',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
              child: CircleAvatar(
                backgroundColor: Colors.white24,
                child: Icon(Icons.person, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: cardPadding, vertical: cardPadding / 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildStatCard(
                    title: 'Total Categories',
                    value: '10',
                    imagePath: 'assets/categories_illustration.jpg',
                    color: Colors.blue[50]!,
                    cardHeight: cardHeight,
                    cardWidth: cardWidth,
                  ),
                  SizedBox(height: 16),
                  _buildStatCard(
                    title: 'Total Products',
                    value: '100',
                    imagePath: 'assets/products_illustration.jpg',
                    color: Colors.green[50]!,
                    cardHeight: cardHeight,
                    cardWidth: cardWidth,
                  ),
                  SizedBox(height: 16),
                  _buildStatCard(
                    title: 'Total Orders',
                    value: '25',
                    imagePath: 'assets/orders_illustration.jpg',
                    color: Colors.orange[50]!,
                    cardHeight: cardHeight,
                    cardWidth: cardWidth,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: MediCareBottomNavigation(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required String imagePath,
    required Color color,
    required double cardHeight,
    required double cardWidth,
  }) {
    return Container(
      width: cardWidth,
      height: cardHeight,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.contain,
          alignment: Alignment.centerRight,
          opacity: 0.3,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}