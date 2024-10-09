import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Shop extends StatefulWidget {
  @override
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> _imageUrls = [];

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    QuerySnapshot snapshot = await _firestore.collection('images').get();
    setState(() {
      _imageUrls = snapshot.docs.map((doc) => doc['url'] as String).toList();
    });
  }

  Future<void> _addImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File file = File(pickedFile.path);
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      try {
        // Uploading to Firebase Storage
        TaskSnapshot snapshot =
            await _storage.ref('images/$fileName').putFile(file);
        String downloadUrl = await snapshot.ref.getDownloadURL();

        // Save the image URL in Firestore
        await _firestore.collection('images').add({'url': downloadUrl});

        // Update local state
        setState(() {
          _imageUrls.add(downloadUrl);
        });
      } catch (e) {
        print("Error uploading image: $e");
      }
    }
  }

  Future<void> _removeImage(String url) async {
    // Remove from Firestore
    QuerySnapshot snapshot = await _firestore
        .collection('images')
        .where('url', isEqualTo: url)
        .get();
    if (snapshot.docs.isNotEmpty) {
      await _firestore
          .collection('images')
          .doc(snapshot.docs.first.id)
          .delete();
    }

    // Remove from local state
    setState(() {
      _imageUrls.remove(url);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 4, 37, 72),
      appBar: AppBar(
        title: Text(
          'เพิ่มข้อมูลร้านตัดผม',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor:
            const Color.fromARGB(255, 4, 37, 72), // เปลี่ยนสี AppBar
        iconTheme: IconThemeData(
          color: Colors.white, // เปลี่ยนสีลูกศรย้อนกลับเป็นสีขาว
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _imageUrls.length,
              itemBuilder: (context, index) {
                return Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Image.network(
                      _imageUrls[index],
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.fill,
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removeImage(_imageUrls[index]),
                    ),
                  ],
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: _addImage,
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
