import 'package:barberapp/Camera/HairstyleOverlayScreen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _image;
  final picker = ImagePicker();

  // ฟังก์ชันสำหรับการเลือกภาพจากแกลเลอรี
  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  // ฟังก์ชันสำหรับการถ่ายภาพ
  Future<void> _captureImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image captured.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 10, 36, 66),
      appBar: AppBar(
        title: Text('เลือกทรงผม'),
        backgroundColor: const Color.fromARGB(255, 10, 36, 66), // เปลี่ยนสีพื้นหลังของ AppBar
        foregroundColor: Colors.white, // เปลี่ยนสีของตัวอักษร
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _image == null
                  ? Text(
                      'ไม่พบรูปภาพ',
                      style: TextStyle(color: Colors.white),
                    )
                  : Image.file(_image!),
              ElevatedButton(
                onPressed: _pickImage,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, // สีของตัวอักษร
                  backgroundColor: Colors.orange,
                ),
                child: Text(
                  'เลือกรูปในคลังรูปภาพ',
                  style: TextStyle(fontSize: 26),
                ),
              ),
              ElevatedButton(
                onPressed: _captureImage,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, // สีของตัวอักษร
                  backgroundColor: Colors.orange,
                ),
                child: Text(
                  'กล้องถ่ายรูป',
                  style: TextStyle(fontSize: 26),
                ),
              ),
              if (_image != null)
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            HairstyleOverlayScreen(image: _image),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, // สีของตัวอักษร
                    backgroundColor: Colors.orange,
                  ),
                  child: Text(
                    'เปลี่ยนทรงผม',
                    style: TextStyle(fontSize: 26),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
