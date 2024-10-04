// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// class AddFaceDataPage extends StatefulWidget {
//   @override
//   _AddFaceDataPageState createState() => _AddFaceDataPageState();
// }

// class _AddFaceDataPageState extends State<AddFaceDataPage> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   File? _imageFile;

//   Future<void> _uploadData() async {
//     if (_nameController.text.isNotEmpty &&
//         _descriptionController.text.isNotEmpty &&
//         _imageFile != null) {
//       String fileName = DateTime.now().millisecondsSinceEpoch.toString();
//       UploadTask uploadTask = FirebaseStorage.instance
//           .ref('faceUploads/$fileName')
//           .putFile(_imageFile!);

//       TaskSnapshot snapshot = await uploadTask;
//       String imageUrl = await snapshot.ref.getDownloadURL();

//       // เพิ่มข้อมูลในคอลเล็คชัน 'FaceData'
//       FirebaseFirestore.instance.collection('FaceData').add({
//         'name': _nameController.text,
//         'description': _descriptionController.text,
//         'imageUrl': imageUrl,
//         'fileName': fileName, // บันทึกชื่อไฟล์เพื่อลบรูปออกจาก Storage
//         'createdAt': FieldValue.serverTimestamp(),
//       });

//       _nameController.clear();
//       _descriptionController.clear();
//       setState(() {
//         _imageFile = null;
//       });

//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('อัปโหลดข้อมูลเรียบร้อยแล้ว')));
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('กรุณากรอกข้อมูลทั้งหมดและเลือกรูปภาพ')));
//     }
//   }

//   Future<void> _deleteData(String docId, String? fileName) async {
//     // ลบข้อมูลใน Firestore
//     await FirebaseFirestore.instance.collection('FaceData').doc(docId).delete();

//     // ลบรูปใน Firebase Storage ถ้า fileName ไม่เป็น null
//     if (fileName != null && fileName.isNotEmpty) {
//       await FirebaseStorage.instance.ref('faceUploads/$fileName').delete();
//     }

//     ScaffoldMessenger.of(context)
//         .showSnackBar(SnackBar(content: Text('ลบข้อมูลเรียบร้อยแล้ว')));
//   }

//   Future<void> _pickImage() async {
//     final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('เพิ่มข้อมูล Face')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _nameController,
//               decoration: InputDecoration(labelText: 'กรอกชื่อ'),
//             ),
//             SizedBox(height: 20),
//             TextField(
//               controller: _descriptionController,
//               decoration: InputDecoration(labelText: 'กรอกคำอธิบาย'),
//             ),
//             SizedBox(height: 20),
//             _imageFile != null
//                 ? Image.file(_imageFile!, height: 150)
//                 : Text('ยังไม่ได้เลือกรูปภาพ'),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: _pickImage,
//               child: Text('เลือกรูปภาพ'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _uploadData,
//               child: Text('บันทึกข้อมูล'),
//             ),
//             SizedBox(height: 20),
//             Expanded(
//               child: StreamBuilder(
//                 stream: FirebaseFirestore.instance
//                     .collection('FaceData')
//                     .orderBy('createdAt', descending: true)
//                     .snapshots(),
//                 builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                   if (!snapshot.hasData) {
//                     return Center(child: CircularProgressIndicator());
//                   }

//                   return ListView.builder(
//                     itemCount: snapshot.data!.docs.length,
//                     itemBuilder: (context, index) {
//                       var document = snapshot.data!.docs[index];
//                       var data = document.data() as Map<String, dynamic>;
//                       var docId = document.id;
//                       var fileName = data['fileName'];

//                       return ListTile(
//                         title: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             data['imageUrl'] != null
//                                 ? Image.network(data['imageUrl'], height: 150)
//                                 : Container(),
//                             SizedBox(height: 10),
//                             Text(
//                               data['name'] ?? 'ไม่มีชื่อ',
//                               textAlign: TextAlign.center,
//                             ),
//                             Text(
//                               data['description'] ?? 'ไม่มีคำอธิบาย',
//                               textAlign: TextAlign.center,
//                             ),
//                           ],
//                         ),
//                         trailing: IconButton(
//                           icon: Icon(Icons.delete, color: Colors.red),
//                           onPressed: () => _deleteData(docId, fileName),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddFaceDataPage extends StatefulWidget {
  @override
  _AddFaceDataPageState createState() => _AddFaceDataPageState();
}

class _AddFaceDataPageState extends State<AddFaceDataPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  File? _imageFile;

  Future<void> _uploadData() async {
    if (_nameController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _imageFile != null) {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      UploadTask uploadTask = FirebaseStorage.instance
          .ref('faceUploads/$fileName')
          .putFile(_imageFile!);

      TaskSnapshot snapshot = await uploadTask;
      String imageUrl = await snapshot.ref.getDownloadURL();

      FirebaseFirestore.instance.collection('FaceData').add({
        'name': _nameController.text,
        'description': _descriptionController.text,
        'imageUrl': imageUrl,
        'fileName': fileName,
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
    await FirebaseFirestore.instance.collection('FaceData').doc(docId).delete();

    if (fileName != null && fileName.isNotEmpty) {
      await FirebaseStorage.instance.ref('faceUploads/$fileName').delete();
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('ลบข้อมูลเรียบร้อยแล้ว')));
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 4, 37, 72),
      appBar: AppBar(
        title: Text(
          'เพิ่มข้อมูลใบหน้า',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor:
            const Color.fromARGB(255, 4, 37, 72), // เปลี่ยนสี AppBar
        iconTheme: IconThemeData(
          color: Colors.white, // เปลี่ยนสีลูกศรย้อนกลับเป็นสีขาว
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                style:
                    TextStyle(color: Colors.white), // กำหนดสีของข้อความที่กรอก
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
                style:
                    TextStyle(color: Colors.white), // กำหนดสีของข้อความที่กรอก
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
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(_imageFile!, height: 150),
                    )
                  : Text(
                      'ยังไม่ได้เลือกรูปภาพ',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 236, 26, 26)),
                    ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _pickImage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  textStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                  textStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                    .collection('FaceData')
                    .orderBy('createdAt', descending: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
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
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: data['imageUrl'] != null
                                    ? Image.network(data['imageUrl'],
                                        height: 150)
                                    : Container(),
                              ),
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
