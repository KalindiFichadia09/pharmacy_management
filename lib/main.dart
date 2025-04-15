import 'package:flutter/material.dart';
import 'package:pharmacy_management/screens/admin/view_category.dart';
import 'screens/Splash.dart'; 
import 'screens/admin/admin_dashboard.dart';
import 'screens/admin/add_category.dart';
import 'package:pharmacy_management/screens/admin/view_category.dart';
import 'screens/admin/view_products.dart';
import 'screens/admin/all_orders.dart';
import 'screens/admin/all_users.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MediCare',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      
      home: SplashScreen(),  
       routes: {
        '/dashboard': (context) => MediCareAdminDashboard(),
        '/addCategory': (context) => AddCategoryPage(),
        '/viewCategories': (context) => ViewCategoriesPage(),
        '/viewProducts': (context) => ViewProductsPage(),
        // '/addProducts' : (context) => AddCategoryPage(
        // ),
        '/allorders': (context) => AllOrdersPage(),
        '/allusers': (context) => AllUsersPage(),
      },
    );
  }
}
