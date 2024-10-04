import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddDataPage extends StatefulWidget {
  @override
  _AddDataPageState createState() => _AddDataPageState();
}

class _AddDataPageState extends State<AddDataPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  Future<void> _uploadData() async {
    if (_nameController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _imageFile != null) {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      UploadTask uploadTask = FirebaseStorage.instance
          .ref('uploads/$fileName')
          .putFile(_imageFile!);

      TaskSnapshot snapshot = await uploadTask;
      String imageUrl = await snapshot.ref.getDownloadURL();

      FirebaseFirestore.instance.collection('shopData').add({
        'name': _nameController.text,
        'description': _descriptionController.text,
        'imageUrl': imageUrl,
        'fileName': fileName, // บันทึกชื่อไฟล์เพื่อลบไฟล์ใน Storage ได้
        'createdAt': FieldValue.serverTimestamp(),
      });

      _nameController.clear();
      _descriptionController.clear();
      setState(() {
        _imageFile = null;
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('อัปโหลดข้อมูลเรียบร้อยแล้ว')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('กรุณากรอกข้อมูลทั้งหมดและเลือกรูปภาพ')));
    }
  }

  Future<void> _deleteData(String docId, String? fileName) async {
    // ลบข้อมูลใน Firestore
    await FirebaseFirestore.instance.collection('shopData').doc(docId).delete();

    // ลบรูปใน Firebase Storage ถ้า fileName ไม่เป็น null และไม่เป็นสตริงว่าง
    if (fileName != null && fileName.isNotEmpty) {
      await FirebaseStorage.instance.ref('uploads/$fileName').delete();
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('ลบข้อมูลเรียบร้อยแล้ว')));
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Color.fromARGB(255, 4, 37, 72),
    appBar: AppBar(
      title: Text(
        'เพิ่มข้อมูลทรงผม',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: const Color.fromARGB(255, 4, 37, 72),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    body: SingleChildScrollView(  // ใช้ SingleChildScrollView ที่นี่
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'กรอกชื่อ',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _descriptionController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'กรอกคำอธิบาย',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            _imageFile != null
                ? Image.file(_imageFile!, height: 150)
                : Text(
                    'ยังไม่ได้เลือกรูปภาพ',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 233, 51, 51)),
                  ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _pickImage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'เลือกรูปภาพ',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadData,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'บันทึกข้อมูล',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('shopData')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                return ListView.builder(
                  shrinkWrap: true, // สำคัญ: เพื่อให้ขนาดของ ListView พอดีกับเนื้อหา
                  physics: NeverScrollableScrollPhysics(), // ปิดการเลื่อนของ ListView แยกต่างหาก
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var document = snapshot.data!.docs[index];
                    var data = document.data() as Map<String, dynamic>;
                    var docId = document.id;
                    var fileName = data['fileName'];

                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5,
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            data['imageUrl'] != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      data['imageUrl'],
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Container(),
                            SizedBox(height: 10),
                            Text(
                              data['name'] ?? 'ไม่มีชื่อ',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              data['description'] ?? 'ไม่มีคำอธิบาย',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteData(docId, fileName),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    ),
  );
}
}