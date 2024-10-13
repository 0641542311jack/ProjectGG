// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class HairstyleViewScreen extends StatefulWidget {
//   @override
//   _HairstyleViewScreenState createState() => _HairstyleViewScreenState();
// }

// class _HairstyleViewScreenState extends State<HairstyleViewScreen> {
//   List<File> hairstyleImages = [];  // รายการเก็บภาพทรงผมที่เพิ่ม
//   List<String> hairstyleImageIds = []; // รายการเก็บ Document ID ของภาพใน Firestore
//   int selectedHairstyleIndex = -1;  // อินเด็กซ์ของทรงผมที่ถูกเลือก (-1 หมายถึงไม่มี)

//   @override
//   void initState() {
//     super.initState();
//     _loadHairstyles();  // โหลดรูปภาพทรงผมเมื่อเริ่มต้น
//   }

//   // โหลดรูปภาพที่เคยบันทึกไว้จาก Firestore
//   Future<void> _loadHairstyles() async {
//     FirebaseFirestore firestore = FirebaseFirestore.instance;
//     var snapshot = await firestore.collection('HairAdd').get(); // เปลี่ยนชื่อคอลเลกชันที่นี่
//     setState(() {
//       hairstyleImages.clear(); // เคลียร์รายการก่อน
//       hairstyleImageIds.clear(); // เคลียร์ IDs
//       for (var doc in snapshot.docs) {
//         if (doc.data().containsKey('url')) {
//           hairstyleImages.add(File(doc['url'] as String)); // โหลดภาพ
//           hairstyleImageIds.add(doc.id); // เก็บ Document ID
//         }
//       }
//       if (hairstyleImages.isNotEmpty) {
//         selectedHairstyleIndex = 0; // ตั้งทรงผมแรกเป็นทรงที่ถูกเลือก
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('View Hairstyle'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Center(
//               child: selectedHairstyleIndex != -1
//                   ? Image.file(
//                       hairstyleImages[selectedHairstyleIndex],
//                       width: 280, // กำหนดขนาดของภาพที่แสดง
//                     )
//                   : Text('No hairstyle selected'),
//             ),
//           ),
//           Container(
//             height: 100, // กำหนดความสูงสำหรับการเลื่อนภาพ
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal, // ทำให้เลื่อนในแนวนอน
//               itemCount: hairstyleImages.length,
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       selectedHairstyleIndex = index; // ตั้งค่าอินเด็กซ์ที่เลือก
//                     });
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Image.file(
//                       hairstyleImages[index],
//                       width: 80, // กำหนดความกว้างของภาพเล็กในแถบด้านล่าง
//                       height: 80, // กำหนดความสูงของภาพเล็กในแถบด้านล่าง
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
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

class HairstyleViewScreen extends StatefulWidget {
  final File? image;

  HairstyleViewScreen({required this.image});

  @override
  _HairstyleViewScreenState createState() => _HairstyleViewScreenState();
}

class _HairstyleViewScreenState extends State<HairstyleViewScreen> {
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
        title: Text('เลือกทรงผม'),
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
