import 'package:flutter/material.dart';
import 'package:pharmacy_management/screens/BottomNavigation.dart';
import 'package:pharmacy_management/screens/Cart.dart';
import 'package:pharmacy_management/screens/MyOrders.dart';
import 'package:pharmacy_management/screens/SignIn.dart';
import 'package:pharmacy_management/screens/Wishlist.dart';
import 'package:pharmacy_management/screens/YourProfile.dart'; 

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Profile', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          /// Enhanced Header Section
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFF2D5FFF),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // User avatar
                      Container(
                        width: 60,
                        height: 60,
                        child: ClipOval(
                          child: Image.asset(
                            'assets/hgc.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                      SizedBox(width: 15),
                      
                      // User information
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'HCG Hospital',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Welcome to MediCare',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Edit profile button
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.white),
                        onPressed: () {
                          Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => YourProfileScreen())
                          );
                        },
                      ),
                    ],
                  ),
                  
                  // Status and membership info
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatusItem(
                          context, 
                          'Premium', 
                          'Membership',
                          Icons.star
                        ),
                        _buildDivider(),
                        _buildStatusItem(
                          context, 
                          '15', 
                          'Orders',
                          Icons.shopping_bag
                        ),
                        _buildDivider(),
                        _buildStatusItem(
                          context, 
                          '24/7', 
                          'Support',
                          Icons.headset_mic
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          SizedBox(height: 20),

          /// Profile Options List
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              children: [
                _buildProfileOption(context, Icons.person, 'Your Profile', () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => YourProfileScreen())
                  );
                }),
                _buildProfileOption(context, Icons.shopping_bag, 'My Orders', () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => MyOrdersScreen())
                  );
                }),
                _buildProfileOption(context, Icons.favorite, 'My Wishlist', () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => WishlistScreen())
                  );
                }),
                _buildProfileOption(context, Icons.shopping_cart, 'My Cart', () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => CartScreen())
                  );
                }),
                _buildProfileOption(context, Icons.assignment, 'Medical License', () {}),
                
                Divider(height: 30, thickness: 1),
                
                _buildProfileOption(
                  context, 
                  Icons.logout, 
                  'Sign Out', () {
                    Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => SignInScreen())
                  );
                  },
                  isLogout: true,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 4), // Set index for Profile screen
    );
  }

  /// Status Item Widget
  Widget _buildStatusItem(BuildContext context, String value, String label, IconData icon) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.white, size: 16),
            SizedBox(width: 5),
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  /// Vertical Divider
  Widget _buildDivider() {
    return Container(
      height: 30,
      width: 1,
      color: Colors.white.withOpacity(0.3),
    );
  }

  /// Profile Option Widget
  Widget _buildProfileOption(
    BuildContext context, 
    IconData icon, 
    String title, 
    VoidCallback onTap, 
    {bool isLogout = false}
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: isLogout ? Colors.red.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isLogout 
                ? Colors.red.withOpacity(0.2) 
                : Color(0xFF2D5FFF).withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon, 
            color: isLogout ? Colors.red : Color(0xFF2D5FFF),
            size: 20,
          ),
        ),
        title: Text(
          title, 
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isLogout ? Colors.red : Colors.black87,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios, 
          size: 16, 
          color: isLogout ? Colors.red : Colors.black54,
        ),
        onTap: onTap,
      ),
    );
  }
}