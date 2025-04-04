import 'package:flutter/material.dart';
import 'package:pharmacy_management/screens/Checkout.dart'; // Import the proper CheckoutScreen

class ReorderScreen extends StatefulWidget {
  final String orderId;
  final String orderDate;
  
  ReorderScreen({
    required this.orderId,
    required this.orderDate,
  });

  @override
  _ReorderScreenState createState() => _ReorderScreenState();
}

class _ReorderScreenState extends State<ReorderScreen> {
  // Sample data for reordering
  List<Map<String, dynamic>> orderItems = [
    {
      'id': 1,
      'name': 'Paracetamol Tablet',
      'description': '500mg, 10 tablets',
      'price': 35,
      'image': 'assets/product.png',
      'isSelected': true,
      'quantity': 1,
    },
    {
      'id': 2,
      'name': 'Azithromycin Tablet',
      'description': '250mg, 6 tablets',
      'price': 55,
      'image': 'assets/product.png',
      'isSelected': true,
      'quantity': 1,
    },
    {
      'id': 3,
      'name': 'Vitamin C Tablet',
      'description': '500mg, 10 tablets',
      'price': 35,
      'image': 'assets/product.png',
      'isSelected': true,
      'quantity': 1,
    },
  ];

  double get totalAmount {
    return orderItems
        .where((item) => item['isSelected'])
        .fold(0, (sum, item) => sum + (item['price'] * item['quantity']));
  }

  int get selectedItemCount {
    return orderItems.where((item) => item['isSelected']).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Reorder', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Original order info
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.grey.shade100,
            child: Row(
              children: [
                Icon(Icons.history, color: Color(0xFF2D5FFF)),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reordering from Order #${widget.orderId}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Original order placed on ${widget.orderDate}',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Select all items
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select Items to Reorder',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton.icon(
                  icon: Icon(
                    allItemsSelected ? Icons.check_circle : Icons.check_circle_outline,
                    color: Color(0xFF2D5FFF),
                  ),
                  label: Text(
                    'Select All',
                    style: TextStyle(
                      color: Color(0xFF2D5FFF),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      bool newValue = !allItemsSelected;
                      for (var item in orderItems) {
                        item['isSelected'] = newValue;
                      }
                    });
                  },
                ),
              ],
            ),
          ),
          
          // Order items list
          Expanded(
            child: ListView.builder(
              itemCount: orderItems.length,
              itemBuilder: (context, index) {
                final item = orderItems[index];
                return _buildOrderItem(item, index);
              },
            ),
          ),
          
          // Bottom action bar
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, -1),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$selectedItemCount Items Selected',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '₹${totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D5FFF),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: selectedItemCount > 0 ? () => _proceedToCheckout(context) : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2D5FFF),
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Place Order',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool get allItemsSelected {
    return orderItems.every((item) => item['isSelected']);
  }

  Widget _buildOrderItem(Map<String, dynamic> item, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Checkbox
          GestureDetector(
            onTap: () {
              setState(() {
                item['isSelected'] = !item['isSelected'];
              });
            },
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: item['isSelected'] ? Color(0xFF2D5FFF) : Colors.grey.shade400,
                  width: 2,
                ),
                color: item['isSelected'] ? Color(0xFF2D5FFF) : Colors.transparent,
              ),
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
          
          SizedBox(width: 12),
          
          // Item image
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Image.asset(
                item['image'],
                width: 40,
                height: 40,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.medical_services,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          
          SizedBox(width: 12),
          
          // Item details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'],
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  item['description'],
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '₹${item['price']}',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Color(0xFF2D5FFF),
                  ),
                ),
              ],
            ),
          ),
          
          // Quantity selector
          if (item['isSelected'])
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  _buildQuantityButton(
                    icon: Icons.remove,
                    onPressed: item['quantity'] > 1
                        ? () {
                            setState(() {
                              item['quantity']--;
                            });
                          }
                        : null,
                  ),
                  Container(
                    width: 30,
                    alignment: Alignment.center,
                    child: Text(
                      '${item['quantity']}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  _buildQuantityButton(
                    icon: Icons.add,
                    onPressed: () {
                      setState(() {
                        item['quantity']++;
                      });
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    required VoidCallback? onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: onPressed == null ? Colors.grey.shade200 : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(
          icon,
          size: 18,
          color: onPressed == null ? Colors.grey.shade500 : Colors.black,
        ),
      ),
    );
  }

  void _proceedToCheckout(BuildContext context) {
    // Extract selected items
    final selectedItems = orderItems.where((item) => item['isSelected']).toList();
    
    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Place Order'),
        content: Text('Proceed to checkout with ${selectedItems.length} selected items?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              
              // Navigate to CheckoutScreen with the total amount
              // This uses the external CheckoutScreen class
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CheckoutScreen(total: totalAmount),
                ),
              );
            },
            child: Text(
              'Proceed',
              style: TextStyle(color: Color(0xFF2D5FFF)),
            ),
          ),
        ],
      ),
    );
  }
}