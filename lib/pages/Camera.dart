import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CameraExample extends StatefulWidget {
  @override
  _CameraExampleState createState() => _CameraExampleState();
}

class _CameraExampleState extends State<CameraExample> {
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;

  Future<void> _takePicture() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ถ่ายภาพ'),
      ),
      body: Center(
        child: _imageFile == null
            ? Text('ยังไม่มีรูปภาพ')
            : Image.file(_imageFile!),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _takePicture,
        tooltip: 'Take a Picture',
        child: Icon(Icons.camera),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: CameraExample()));
}
