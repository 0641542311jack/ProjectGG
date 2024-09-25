import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:gallery_saver/gallery_saver.dart';

class HairstyleOverlayScreen extends StatefulWidget {
  final File? image;

  HairstyleOverlayScreen({required this.image});

  @override
  _HairstyleOverlayScreenState createState() => _HairstyleOverlayScreenState();
}

class _HairstyleOverlayScreenState extends State<HairstyleOverlayScreen> {
  int selectedHairstyle = 0;
  final ScreenshotController screenshotController = ScreenshotController();
  Offset position = Offset(0, 0);
  double scale = 1.0;

  final List<String> hairstyleImages = [
    'images/hair001.png',
    'images/hair002.png',
    'images/hair003.png',
  ];

  final List<Map<String, dynamic>> hairstylePositions = [
    {'top': 200.0, 'left': 58.0, 'width': 280.0},
    {'top': 200.0, 'left': 58.0, 'width': 280.0},
    {'top': 200.0, 'left': 58.0, 'width': 280.0},
    
  ];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose a Hairstyle'),
      ),
      body: Stack(
        children: [
          Screenshot(
            controller: screenshotController,
            child: Stack(
              children: [
                Center(child: Image.file(widget.image!)),
                if (selectedHairstyle != null)
                  Positioned(
                    top: hairstylePositions[selectedHairstyle]['top'] + position.dy,
                    left: hairstylePositions[selectedHairstyle]['left'] + position.dx,
                    width: hairstylePositions[selectedHairstyle]['width'] * scale,
                    child: GestureDetector(
                      onScaleUpdate: (details) {
                        setState(() {
                          scale = details.scale;  // ขยายตามการขยายของนิ้ว
                          position = Offset(
                            position.dx + details.focalPointDelta.dx,
                            position.dy + details.focalPointDelta.dy,
                          );  // เคลื่อนที่ตามการเคลื่อนย้ายของนิ้ว
                        });
                      },
                      child: Transform.scale(
                        scale: scale,
                        child: Image.asset(hairstyleImages[selectedHairstyle]),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.face), label: 'ทรงที่ 1'),
          BottomNavigationBarItem(icon: Icon(Icons.face), label: 'ทรงที่ 2'),
          BottomNavigationBarItem(icon: Icon(Icons.face), label: 'ทรงที่ 3'),
        ],
        currentIndex: selectedHairstyle,
        onTap: (index) {
          setState(() {
            selectedHairstyle = index;
            position = Offset(0, 0);  // รีเซ็ตตำแหน่งเมื่อเปลี่ยนทรงผม
            scale = 1.0;  // รีเซ็ตขนาดเมื่อเปลี่ยนทรงผม
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveImage,
        child: Icon(Icons.save),
      ),
    );
  }
}