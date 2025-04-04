import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditCategoryPage extends StatefulWidget {
  final Map<String, String> categoryData;
  
  EditCategoryPage({required this.categoryData});
  
  @override
  _EditCategoryPageState createState() => _EditCategoryPageState();
}

class _EditCategoryPageState extends State<EditCategoryPage> {
  late TextEditingController _categoryNameController;
  File? _image;
  String? _existingImagePath;

  @override
  void initState() {
    super.initState();
   
    _categoryNameController = TextEditingController(text: widget.categoryData['name']);
    _existingImagePath = widget.categoryData['image'];
  }

  @override
  void dispose() {
    _categoryNameController.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xFF2D5FFF),
        title: Row(
          children: [
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'MediCare',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Edit Category',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Category Name", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            TextField(
              controller: _categoryNameController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                hintText: "Enter Category Name",
              ),
            ),
            SizedBox(height: 16),
            Text("Category Image:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                onPressed: () {
                  final updatedCategory = {
                    'name': _categoryNameController.text,
                    'image': _image != null ? _image!.path : _existingImagePath,
                  };
                  
                  print("Category Updated: ${updatedCategory['name']}");
                  // Navigate back to view categories
                  Navigator.pop(context, updatedCategory);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2D5FFF),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: Text("Update Category", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _displayImageWidget() {
    if (_image != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.file(_image!, fit: BoxFit.cover),
      );
    } 
    else if (_existingImagePath != null) 
    {
    
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          _existingImagePath!,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => 
            Center(child: Text("Image not found", style: TextStyle(color: Colors.black54))),
        ),
      );
    } 
    else 
    {
      return Center(child: Text("Select An Image", style: TextStyle(color: Colors.black54)));
    }
  }
}