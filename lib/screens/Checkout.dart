import 'package:flutter/material.dart';
import 'package:pharmacy_management/screens/BottomNavigation.dart';

class CheckoutScreen extends StatefulWidget {
  final double total;
  
  const CheckoutScreen({Key? key, required this.total}) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  // Payment method options
  final List<String> paymentMethods = [ 'Cash on Delivery', 'UPI'];
  String selectedPaymentMethod = 'Credit Card';
  
  // Address options
  final List<Address> addresses = [
    Address(
      id: 1,
      name: 'Home',
      addressLine: '123 Main Street, Apartment 4B',
      city: 'Mumbai',
      state: 'Maharashtra',
      postalCode: '400001',
      isDefault: true,
    ),
    Address(
      id: 2,
      name: 'Office',
      addressLine: '456 Business Park, Floor 5',
      city: 'Mumbai',
      state: 'Maharashtra',
      postalCode: '400051',
      isDefault: false,
    ),
  ];
  
  Address? selectedAddress;
  
  @override
  void initState() {
    super.initState();
    // Select default address
    selectedAddress = addresses.firstWhere((address) => address.isDefault, orElse: () => addresses.first);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Checkout'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Delivery Address Section
              const Text(
                'Delivery Address',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              
              // Address Cards
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: addresses.length,
                itemBuilder: (context, index) {
                  return AddressCard(
                    address: addresses[index],
                    isSelected: selectedAddress?.id == addresses[index].id,
                    onTap: () {
                      setState(() {
                        selectedAddress = addresses[index];
                      });
                    },
                  );
                },
              ),
              
              TextButton.icon(
                onPressed: () {
                  // Add address navigation would go here
                },
                icon: const Icon(Icons.add, color: Color(0xFF2D5FFF)),
                label: const Text(
                  'Add New Address',
                  style: TextStyle(color: Color(0xFF2D5FFF)),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Payment Method Section
              const Text(
                'Payment Method',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              
              // Payment Method Cards
              Column(
                children: paymentMethods.map((method) {
                  return PaymentMethodCard(
                    method: method,
                    isSelected: selectedPaymentMethod == method,
                    onTap: () {
                      setState(() {
                        selectedPaymentMethod = method;
                      });
                    },
                  );
                }).toList(),
              ),
              
              const SizedBox(height: 24),
              
              // Order Summary Section
              const Text(
                'Order Summary',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total Amount'),
                        Text(
                          'Rs.${widget.total.toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Delivery Fee'),
                        Text('Free'),
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Place Order Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Process order
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Order Placed'),
                          content: const Text('Your order has been placed successfully!'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                // Navigate to home or order confirmation
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2D5FFF),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Place Order',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: 3),
    );
  }
}

class Address {
  final int id;
  final String name;
  final String addressLine;
  final String city;
  final String state;
  final String postalCode;
  final bool isDefault;
  
  Address({
    required this.id,
    required this.name,
    required this.addressLine,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.isDefault,
  });
}

class AddressCard extends StatelessWidget {
  final Address address;
  final bool isSelected;
  final VoidCallback onTap;
  
  const AddressCard({
    Key? key,
    required this.address,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? const Color(0xFF2D5FFF) : Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? const Color(0xFF2D5FFF) : Colors.transparent,
                border: Border.all(
                  color: isSelected ? const Color(0xFF2D5FFF) : Colors.grey.shade400,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        address.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (address.isDefault)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'Default',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(address.addressLine),
                  Text('${address.city}, ${address.state} ${address.postalCode}'),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.grey),
              onPressed: () {
                // Edit address
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentMethodCard extends StatelessWidget {
  final String method;
  final bool isSelected;
  final VoidCallback onTap;
  
  const PaymentMethodCard({
    Key? key,
    required this.method,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);
  
  IconData getIcon() {
    switch (method) {
      case 'Cash on Delivery':
        return Icons.money;
      case 'UPI':
        return Icons.account_balance;
      default:
        return Icons.payment;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? const Color(0xFF2D5FFF) : Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? const Color(0xFF2D5FFF) : Colors.transparent,
                border: Border.all(
                  color: isSelected ? const Color(0xFF2D5FFF) : Colors.grey.shade400,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 12),
            Icon(getIcon()),
            const SizedBox(width: 8),
            Text(
              method,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}