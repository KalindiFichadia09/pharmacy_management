import 'package:flutter/material.dart';
import 'package:pharmacy_management/screens/BottomNavigation.dart';
import 'package:pharmacy_management/screens/Expore.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Top Header
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: BoxDecoration(
                color: Color(0xFF2D5FFF),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  // ✅ Logo, Hospital Name & Cart Icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/logo.png", height: 50),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("HCG Hospital",
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              Text("Welcome to MediCare",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white70)),
                            ],
                          ),
                        ],
                      ),
                      Icon(Icons.shopping_cart, color: Colors.white, size: 28),
                    ],
                  ),

                  SizedBox(height: 10),
                  // ✅ Search Bar
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search Medicine & Healthcare products",
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // ✅ Top Categories
            _buildSectionTitle("Top Categories"),
            SizedBox(height: 10),
            _buildCategoryRow(),
            SizedBox(height: 20),

            // ✅ Banner
            _buildBanner(),
            SizedBox(height: 20),

            // ✅ Deals of the Day
            _buildSectionTitle("Deals of the Day"),
            SizedBox(height: 10),
            _buildDealsList(),
          ],
        ),
      ),

      // ✅ Bottom Navigation Bar (Using the Separate Widget)
      bottomNavigationBar: BottomNavBar(currentIndex: 0),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Text(title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildCategoryRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildCategory("Eye", Colors.pink),
        _buildCategory("Ear", Colors.green),
        _buildCategory("Skin", Colors.orange),
        _buildCategory("Digestive", Colors.blue),
      ],
    );
  }

  Widget _buildCategory(String title, Color color) {
    return Column(
      children: [
        CircleAvatar(radius: 30, backgroundColor: color),
        SizedBox(height: 5),
        Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildBanner() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset("assets/banner.png"),
      ),
    );
  }

  Widget _buildDealsList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(4, (index) => _buildProductCard()),
      ),
    );
  }

  Widget _buildProductCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5, spreadRadius: 2),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/product.png", height: 100),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Accu-check Active Test Strip",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Rs. 112",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue)),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 173, 161, 54),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, size: 16, color: Colors.white),
                      Text("5", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
