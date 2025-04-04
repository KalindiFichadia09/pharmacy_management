import 'package:flutter/material.dart';
import 'package:pharmacy_management/screens/Reorder.dart';

class OrderTrackingScreen extends StatelessWidget {
  final String orderId;
  final String trackingNumber;
  
  // Constructor to receive order information
  OrderTrackingScreen({
    required this.orderId,
    required this.trackingNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Order Details', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order Header
              _buildOrderHeader(),
              
              SizedBox(height: 20),
              
              // Tracking Progress
              _buildTrackingProgress(),
              
              SizedBox(height: 30),
              
              // Order Items
              Text(
                'Order Items',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              _buildOrderItems(),
              
              SizedBox(height: 30),
              
              // Order Information
              Text(
                'Order Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              _buildOrderInformation(),
              
              SizedBox(height: 30),
              
              // Payment Information
              Text(
                'Payment Details',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              _buildPaymentDetails(),
              
              SizedBox(height: 30),
              
              // Shipping Address
              Text(
                'Shipping Address',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              _buildShippingAddress(),
              
              SizedBox(height: 40),
              
              // Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Reorder functionality
                        Navigator.push(
                          context,
                            MaterialPageRoute(
                            builder: (context) => ReorderScreen(
                            orderId: '1947034',
                            orderDate: '05-12-2019',
                          ),
                        ),
                      );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF2D5FFF),
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Reorder',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 20),
              
              // Cancel order button
              Center(
                child: TextButton(
                  onPressed: () {
                    // Show cancel confirmation dialog
                    _showCancelDialog(context);
                  },
                  child: Text(
                    'Cancel Order',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderHeader() {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order №$orderId',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Delivered',
                  style: TextStyle(
                    color: Colors.green.shade800,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            'Placed on 05 Dec, 2019 at 12:30 PM',
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text(
                'Tracking Number: ',
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 14,
                ),
              ),
              Text(
                trackingNumber,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrackingProgress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tracking',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Column(
              children: [
                _buildTrackingIcon(Icons.check_circle, Colors.green, true),
                Container(
                  width: 2,
                  height: 30,
                  color: Colors.green,
                ),
                _buildTrackingIcon(Icons.check_circle, Colors.green, true),
                Container(
                  width: 2,
                  height: 30,
                  color: Colors.green,
                ),
                _buildTrackingIcon(Icons.check_circle, Colors.green, true),
                Container(
                  width: 2,
                  height: 30,
                  color: Colors.green,
                ),
                _buildTrackingIcon(Icons.check_circle, Colors.green, true),
              ],
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTrackingStep('Order Placed', 'Dec 5, 2019, 12:30 PM'),
                  SizedBox(height: 15),
                  _buildTrackingStep('Order Confirmed', 'Dec 5, 2019, 1:45 PM'),
                  SizedBox(height: 15),
                  _buildTrackingStep('Order Shipped', 'Dec 6, 2019, 10:25 AM'),
                  SizedBox(height: 15),
                  _buildTrackingStep('Order Delivered', 'Dec 7, 2019, 5:30 PM'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTrackingIcon(IconData icon, Color color, bool isCompleted) {
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: color,
        size: 24,
      ),
    );
  }

  Widget _buildTrackingStep(String title, String time) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        SizedBox(height: 4),
        Text(
          time,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildOrderItems() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildOrderItem(
            'assets/medicine1.png',
            'Paracetamol Tablet',
            '500mg, 10 tablets',
            '₹35',
            1,
          ),
          Divider(height: 1),
          _buildOrderItem(
            'assets/medicine2.png',
            'Azithromycin Tablet',
            '250mg, 6 tablets',
            '₹55',
            1,
          ),
          Divider(height: 1),
          _buildOrderItem(
            'assets/medicine3.png',
            'Vitamin C Tablet',
            '500mg, 10 tablets',
            '₹35',
            1,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '₹125',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(String image, String name, String description, String price, int quantity) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Image.asset(
                image,
                width: 40,
                height: 40,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.medical_services, color: Colors.grey),
              ),
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$quantity x $price',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      price,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderInformation() {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildInfoRow('Order Number', orderId),
          SizedBox(height: 10),
          _buildInfoRow('Tracking Number', trackingNumber),
          SizedBox(height: 10),
          _buildInfoRow('Order Date', 'Dec 5, 2019'),
          SizedBox(height: 10),
          _buildInfoRow('Delivery Date', 'Dec 7, 2019'),
        ],
      ),
    );
  }

  Widget _buildPaymentDetails() {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildInfoRow('Payment Method', 'Online Payment'),
          SizedBox(height: 10),
          _buildInfoRow('Items Total', '₹125'),
          SizedBox(height: 10),
          _buildInfoRow('Delivery Fee', '₹30'),
          SizedBox(height: 10),
          _buildInfoRow('Discount', '-₹30'),
          SizedBox(height: 10),
          Divider(),
          SizedBox(height: 10),
          _buildInfoRow('Total Amount', '₹125', isBold: true),
        ],
      ),
    );
  }

  Widget _buildShippingAddress() {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'HCG Multi Speciality Hospital',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Yagnik Road, Rajkot 360004',
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Contact: 7412589630',
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            fontSize: isBold ? 16 : 14,
          ),
        ),
      ],
    );
  }

  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cancel Order'),
          content: Text('Are you sure you want to cancel this order?'),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Yes', style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
                // Add cancel logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Order cancellation requested'))
                );
              },
            ),
          ],
        );
      },
    );
  }
}