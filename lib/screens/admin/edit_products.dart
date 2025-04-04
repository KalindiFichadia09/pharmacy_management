import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditProductsPage extends StatefulWidget {
  final Map<String, dynamic> productData;

  EditProductsPage({required this.productData});

  @override
  _EditProductsPageState createState() => _EditProductsPageState();
}

class _EditProductsPageState extends State<EditProductsPage> {
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _categoryController;
  late TextEditingController _expiryDateController;
  late TextEditingController _detailsController;
  late TextEditingController _ingredientsController;

  File? _image;
  String? _existingImagePath;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.productData['name']);
    _priceController = TextEditingController(text: widget.productData['price']);
    _categoryController = TextEditingController(text: widget.productData['category']);
    _expiryDateController = TextEditingController(text: widget.productData['expiryDate']);
    _detailsController = TextEditingController(text: widget.productData['details']);
    _ingredientsController = TextEditingController(text: widget.productData['ingredients']);
    
    _existingImagePath = widget.productData['image'];
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _categoryController.dispose();
    _expiryDateController.dispose();
    _detailsController.dispose();
    _ingredientsController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _existingImagePath = null;
      });
    }
  }

  void _updateProduct() {
    final updatedProduct = {
      'name': _nameController.text,
      'price': _priceController.text,
      'category': _categoryController.text,
      'expiryDate': _expiryDateController.text,
      'details': _detailsController.text,
      'ingredients': _ingredientsController.text,
      'image': _image != null ? _image!.path : _existingImagePath,
    };

    print("Product Updated: ${updatedProduct['name']}");
    Navigator.pop(context, updatedProduct);
  }

  Widget _displayImageWidget() {
    if (_image != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.file(_image!, fit: BoxFit.cover),
      );
    } else if (_existingImagePath != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          _existingImagePath!,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => 
            Center(child: Text("Image not found", style: TextStyle(color: Colors.black54))),
        ),
      );
    } else {
      return Center(child: Text("Select an Image", style: TextStyle(color: Colors.black54)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Color(0xFF2D5FFF),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'MediCare',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Edit Product',
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField("Product Name", _nameController),
            _buildTextField("Product Price", _priceController, isNumeric: true),
            _buildTextField("Category Name", _categoryController),
            _buildTextField("Medicine’s Expiry Date", _expiryDateController),
            _buildTextField("Product Details", _detailsController, maxLines: 3),
            _buildTextField("Product Ingredients", _ingredientsController, maxLines: 3),
            SizedBox(height: 16),
            Text("Product Image:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
                child: _displayImageWidget(),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _updateProduct,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2D5FFF),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: Text("Update Product", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool isNumeric = false, int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
          maxLines: maxLines,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
            hintText: "Enter $label",
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
