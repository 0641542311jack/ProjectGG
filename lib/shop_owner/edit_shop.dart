import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Picker',
      home: Shop(),
    );
  }
}

class Shop extends StatefulWidget {
  @override
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  final List<XFile> _imageFilesTop = [];  // สำหรับรูปภาพในส่วนบน
  final List<XFile> _imageFilesBottom = []; // สำหรับรูปภาพในส่วนล่าง
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(bool isTop) async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null) {
      setState(() {
        if (isTop) {
          _imageFilesTop.addAll(images);
          _addImagesToFirestore(images, "top");
        } else {
          _imageFilesBottom.addAll(images);
          _addImagesToFirestore(images, "bottom");
        }
      });
    }
  }

  Future<void> _addImagesToFirestore(List<XFile> images, String position) async {
    for (var image in images) {
      await FirebaseFirestore.instance.collection('Shop').add({
        'url': image.path, // แทนที่ด้วย URL ที่ต้องการหากมี
        'position': position,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
  }

  void _removeImage(bool isTop, int index) async {
    if (isTop) {
      await _removeImageFromFirestore(_imageFilesTop[index].path);
      _imageFilesTop.removeAt(index);
    } else {
      await _removeImageFromFirestore(_imageFilesBottom[index].path);
      _imageFilesBottom.removeAt(index);
    }
    setState(() {});
  }

  Future<void> _removeImageFromFirestore(String imagePath) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Shop')
        .where('url', isEqualTo: imagePath)
        .get();

    for (var doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop'),
      ),
      body: Column(
        children: [
          // ส่วนบน
          Expanded(
            child: _imageFilesTop.isEmpty
                ? Center(child: Text('ไม่มีรูปภาพเกี่ยวกับร้านตัดผม'))
                : CarouselSlider(
                    options: CarouselOptions(
                      height: 200,
                      enableInfiniteScroll: false,
                      viewportFraction: 1.0,
                    ),
                    items: _imageFilesTop.map((file) {
                      return Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Image.file(
                            File(file.path),
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              _removeImage(true, _imageFilesTop.indexOf(file));
                            },
                          ),
                        ],
                      );
                    }).toList(),
                  ),
          ),
          ElevatedButton(
            onPressed: () => _pickImage(true),
            child: Icon(Icons.add),
          ),

          // ส่วนล่าง
          Expanded(
            child: _imageFilesBottom.isEmpty
                ? Center(child: Text('ไม่มีรูปภาพผลงานร้านตัดผม'))
                : CarouselSlider(
                    options: CarouselOptions(
                      height: 200,
                      enableInfiniteScroll: false,
                      viewportFraction: 1.0,
                    ),
                    items: _imageFilesBottom.map((file) {
                      return Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Image.file(
                            File(file.path),
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              _removeImage(false, _imageFilesBottom.indexOf(file));
                            },
                          ),
                        ],
                      );
                    }).toList(),
                  ),
          ),
          ElevatedButton(
            onPressed: () => _pickImage(false),
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}