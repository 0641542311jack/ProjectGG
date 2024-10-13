// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:screenshot/screenshot.dart';
// import 'package:gallery_saver/gallery_saver.dart';

// class HairstyleOverlayScreen extends StatefulWidget {
//   final File? image;

//   HairstyleOverlayScreen({required this.image});

//   @override
//   _HairstyleOverlayScreenState createState() => _HairstyleOverlayScreenState();
// }

// class _HairstyleOverlayScreenState extends State<HairstyleOverlayScreen> {
//   int selectedHairstyle = 0;
//   final ScreenshotController screenshotController = ScreenshotController();
//   Offset position = Offset(0, 0);
//   double scale = 1.0;

//   final List<String> hairstyleImages = [
//     'images/hair001.png',
//     'images/hair002.png',
//     'images/hair003.png',
//   ];

//   final List<Map<String, dynamic>> hairstylePositions = [
//     {'top': 200.0, 'left': 58.0, 'width': 280.0},
//     {'top': 200.0, 'left': 58.0, 'width': 280.0},
//     {'top': 200.0, 'left': 58.0, 'width': 280.0},
    
//   ];

//   Future<void> _saveImage() async {
//     screenshotController.capture().then((Uint8List? image) async {
//       if (image != null) {
//         final directory = await getApplicationDocumentsDirectory();
//         final imagePath = await File('${directory.path}/hairstyle.png').create();
//         await imagePath.writeAsBytes(image);

//         await GallerySaver.saveImage(imagePath.path).then((bool? success) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Image saved to gallery!')),
//           );
//         });
//       }
//     }).catchError((onError) {
//       print(onError);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Choose a Hairstyle'),
//       ),
//       body: Stack(
//         children: [
//           Screenshot(
//             controller: screenshotController,
//             child: Stack(
//               children: [
//                 Center(child: Image.file(widget.image!)),
//                 if (selectedHairstyle != null)
//                   Positioned(
//                     top: hairstylePositions[selectedHairstyle]['top'] + position.dy,
//                     left: hairstylePositions[selectedHairstyle]['left'] + position.dx,
//                     width: hairstylePositions[selectedHairstyle]['width'] * scale,
//                     child: GestureDetector(
//                       onScaleUpdate: (details) {
//                         setState(() {
//                           scale = details.scale;  // ขยายตามการขยายของนิ้ว
//                           position = Offset(
//                             position.dx + details.focalPointDelta.dx,
//                             position.dy + details.focalPointDelta.dy,
//                           );  // เคลื่อนที่ตามการเคลื่อนย้ายของนิ้ว
//                         });
//                       },
//                       child: Transform.scale(
//                         scale: scale,
//                         child: Image.asset(hairstyleImages[selectedHairstyle]),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.face), label: 'ทรงที่ 1'),
//           BottomNavigationBarItem(icon: Icon(Icons.face), label: 'ทรงที่ 2'),
//           BottomNavigationBarItem(icon: Icon(Icons.face), label: 'ทรงที่ 3'),
//         ],
//         currentIndex: selectedHairstyle,
//         onTap: (index) {
//           setState(() {
//             selectedHairstyle = index;
//             position = Offset(0, 0);  // รีเซ็ตตำแหน่งเมื่อเปลี่ยนทรงผม
//             scale = 1.0;  // รีเซ็ตขนาดเมื่อเปลี่ยนทรงผม
//           });
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _saveImage,
//         child: Icon(Icons.save),
//       ),
//     );
//   }
// }

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:screenshot/screenshot.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HairstyleOverlayScreen extends StatefulWidget {
  final File? image;

  HairstyleOverlayScreen({required this.image});

  @override
  _HairstyleOverlayScreenState createState() => _HairstyleOverlayScreenState();
}

class _HairstyleOverlayScreenState extends State<HairstyleOverlayScreen> {
  List<File> hairstyleImages = [];  // รายการเก็บภาพทรงผมที่เพิ่ม
  List<String> hairstyleImageIds = []; // รายการเก็บ Document ID ของภาพใน Firestore
  final ScreenshotController screenshotController = ScreenshotController();
  Offset position = Offset(0, 0);  // ตำแหน่งของภาพ
  double scale = 1.0;  // สเกลของภาพ
  int selectedHairstyleIndex = -1;  // อินเด็กซ์ของทรงผมที่ถูกเลือก

  @override
  void initState() {
    super.initState();
    _loadHairstyles();  // โหลดรูปภาพทรงผมเมื่อเริ่มต้น
  }

  // โหลดรูปภาพที่เคยบันทึกไว้จาก Firestore
  Future<void> _loadHairstyles() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var snapshot = await firestore.collection('HairAdd').get(); // เปลี่ยนชื่อคอลเลกชันที่นี่
    setState(() {
      hairstyleImages.clear(); // เคลียร์รายการก่อน
      hairstyleImageIds.clear(); // เคลียร์ IDs
      for (var doc in snapshot.docs) {
        if (doc.data().containsKey('url')) {
          hairstyleImages.add(File(doc['url'] as String)); // โหลดภาพ
          hairstyleImageIds.add(doc.id); // เก็บ Document ID
        }
      }
      if (hairstyleImages.isNotEmpty) {
        selectedHairstyleIndex = 0; // ตั้งทรงผมแรกเป็นทรงที่ถูกเลือก
      }
    });
  }

  // บันทึก URL ของทรงผมใหม่ใน Firestore
  Future<void> _addHairstyle(String imageUrl) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var docRef = await firestore.collection('HairAdd').add({ // เปลี่ยนชื่อคอลเลกชันที่นี่
      'url': imageUrl,
    });
    hairstyleImageIds.add(docRef.id); // เก็บ Document ID ที่ได้จาก Firestore
  }

  // เพิ่มรูปภาพทรงผมใหม่
  Future<void> _addImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        hairstyleImages.add(File(pickedFile.path));
        if (hairstyleImages.length == 1) {
          selectedHairstyleIndex = 0; // ถ้าเป็นทรงแรกที่เพิ่ม ให้เลือกเป็นทรงแรกทันที
        }
      });
      // บันทึก URL ของภาพใน Firestore
      await _addHairstyle(pickedFile.path); // ใช้ path ในการบันทึก URL
      await _loadHairstyles(); // โหลดภาพใหม่จาก Firestore
    }
  }

  // ลบรูปภาพทรงผม
  Future<void> _removeImage(int index) async {
    // ลบจาก Firestore
    await FirebaseFirestore.instance.collection('HairAdd').doc(hairstyleImageIds[index]).delete();
    
    setState(() {
      hairstyleImages.removeAt(index);
      hairstyleImageIds.removeAt(index); // ลบ Document ID
      if (selectedHairstyleIndex >= hairstyleImages.length) {
        selectedHairstyleIndex = hairstyleImages.isNotEmpty ? 0 : -1;
      }
    });
  }

  // บันทึกภาพรวม
  Future<void> _saveImage() async {
    screenshotController.capture().then((Uint8List? image) async {
      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = await File('${directory.path}/hairstyle.png').create();
        await imagePath.writeAsBytes(image);

        await GallerySaver.saveImage(imagePath.path).then((bool? success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Image saved to gallery!')),
          );
        });
      }
    }).catchError((onError) {
      print(onError);
    });
  }

  // คำนวณตำแหน่งและขนาดที่เหมาะสมให้รูปภาพอยู่ตรงกลางหน้าจอ
  void _centerImage(BuildContext context, File image) {
    final screenSize = MediaQuery.of(context).size;
    final imageSize = 280; // กำหนดขนาดของภาพที่เพิ่ม

    setState(() {
      scale = 1.0;  // กำหนดให้สเกลเป็น 1
      position = Offset(
        (screenSize.width - imageSize) / 2,  // ตำแหน่ง x ให้อยู่กลางหน้าจอ
        (screenSize.height - 550) / 2,  // ตำแหน่ง y ให้อยู่กลางหน้าจอ
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add and Edit Hairstyle'),
      ),
      body: Stack(
        children: [
          Screenshot(
            controller: screenshotController,
            child: Stack(
              children: [
                Center(child: Image.file(widget.image!)),
                for (int i = 0; i < hairstyleImages.length; i++)
                  if (i == selectedHairstyleIndex)
                    Positioned(
                      top: position.dy,
                      left: position.dx,
                      child: GestureDetector(
                        onScaleUpdate: (details) {
                          setState(() {
                            scale = details.scale;
                            position = Offset(
                              position.dx + details.focalPointDelta.dx,
                              position.dy + details.focalPointDelta.dy,
                            );
                          });
                        },
                        child: Transform.scale(
                          scale: scale,
                          child: Image.file(hairstyleImages[i], width: 280),
                        ),
                      ),
                    ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _addImage,
            child: Icon(Icons.add),
            heroTag: 'addButton',
          ),
          SizedBox(height: 10),
          if (selectedHairstyleIndex != -1)
            FloatingActionButton(
              onPressed: () => _removeImage(selectedHairstyleIndex),
              child: Icon(Icons.delete),
              heroTag: 'deleteButton',
            ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 100,  // กำหนดความสูงสำหรับการเลื่อนภาพ
        child: ListView.builder(
          scrollDirection: Axis.horizontal,  // ทำให้เลื่อนในแนวนอน
          itemCount: hairstyleImages.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedHairstyleIndex = index;
                  _centerImage(context, hairstyleImages[index]);  // เรียกฟังก์ชันคำนวณตำแหน่งเมื่อเลือกภาพ
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.file(
                  hairstyleImages[index],
                  width: 80,  // กำหนดความกว้างของภาพเล็กในแถบด้านล่าง
                  height: 80,  // กำหนดความสูงของภาพเล็กในแถบด้านล่าง
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

