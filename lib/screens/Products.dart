import 'package:flutter/material.dart';
import 'package:pharmacy_management/screens/BottomNavigation.dart';
import 'package:pharmacy_management/screens/SingleProduct.dart';

class Products extends StatelessWidget {
  final String categoryName;

  const Products({Key? key, required this.categoryName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(currentIndex: 2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          categoryName,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_bag_outlined, color: Colors.black),
                onPressed: () {},
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: const Text(
                    '5',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 240, 240, 245),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Search Medicine",
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SingleProduct(
                            product: products[index],
                          ),
                        ),
                      );
                    },
                    child: ProductCard(product: products[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: Image.asset(
                product.image,
                height: 100,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text(
                  'Rs. ${product.price.toStringAsFixed(0)}',
                  style: const TextStyle(
                    color: Color(0xFF2D5FFF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2D5FFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Add to cart',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
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
}

class Product {
  final String name;
  final String image;
  final double price;
  final String? description;
  final String? details;
  final String? ingredients;

  const Product({
    required this.name,
    required this.image,
    required this.price,
    this.description,
    this.details,
    this.ingredients,
  });
}

// Sample Product Data
List<Product> products = const [
  Product(
    name: 'Timolol',
    image: 'assets/timolol.png',
    price: 80.0,
    description: 'Eye drops for glaucoma treatment',
    details: 'Used to treat high pressure inside the eye due to glaucoma or other eye diseases.',
    ingredients: 'Timolol maleate 0.5%, Benzalkonium chloride, Sodium phosphate, Water for injection',
  ),
  Product(
    name: 'Latanoprost',
    image: 'assets/latanoprost.png',
    price: 112.0,
    description: 'Ophthalmic solution for glaucoma',
    details: 'Helps reduce pressure in the eye by increasing the drainage of aqueous humor.',
    ingredients: 'Latanoprost 0.005%, Benzalkonium chloride, Sodium chloride, Water for injection',
  ),
  Product(
    name: 'Ciprofloxacin',
    image: 'assets/timolol.png',
    price: 120.0,
    description: 'Antibiotic medication',
    details: 'Treats bacterial infections including respiratory, urinary tract, and skin infections.',
    ingredients: 'Ciprofloxacin hydrochloride, Lactose monohydrate, Microcrystalline cellulose, Magnesium stearate',
  ),
  Product(
    name: 'Betahistine',
    image: 'assets/latanoprost.png',
    price: 150.0,
    description: 'Treatment for vertigo',
    details: 'Used to reduce the symptoms of Ménière\'s disease, such as vertigo, tinnitus, and hearing loss.',
    ingredients: 'Betahistine dihydrochloride, Microcrystalline cellulose, Mannitol, Citric acid',
  ),
  Product(
    name: 'Ibuprofen',
    image: 'assets/timolol.png',
    price: 90.0,
    description: 'Pain and fever reducer',
    details: 'Nonsteroidal anti-inflammatory drug used to reduce pain, inflammation, and fever.',
    ingredients: 'Ibuprofen, Microcrystalline cellulose, Corn starch, Croscarmellose sodium',
  ),
  Product(
    name: 'Paracetamol',
    image: 'assets/latanoprost.png',
    price: 60.0,
    description: 'Pain reliever and fever reducer',
    details: 'Treats mild to moderate pain and fever. Safe for most people when used as directed.',
    ingredients: 'Paracetamol, Starch, Povidone, Stearic acid',
  ),
];