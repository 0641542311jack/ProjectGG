import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

class ShopViewer extends StatefulWidget {
  @override
  _ShopViewerState createState() => _ShopViewerState();
}

class _ShopViewerState extends State<ShopViewer> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to fetch images from Firestore by position ("top" or "bottom")
  Stream<QuerySnapshot> _getImagesByPosition(String position) {
    return _firestore
        .collection('Shop')
        .where('position', isEqualTo: position)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop Viewer'),
      ),
      body: Column(
        children: [
          // ส่วนแสดงรูปภาพ "top"
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _getImagesByPosition("top"),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                final images = snapshot.data!.docs;
                if (images.isEmpty) {
                  return Center(child: Text('ไม่มีรูปภาพเกี่ยวกับร้านตัดผม'));
                }

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    final url = images[index]['url'];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.file(
                        File(url), // URL ที่เก็บใน Firestore เป็น path ของไฟล์รูปภาพในเครื่อง
                        fit: BoxFit.cover,
                        width: 200, // ขนาดความกว้างของรูปภาพ
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Divider(),

          // ส่วนแสดงรูปภาพ "bottom"
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _getImagesByPosition("bottom"),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                final images = snapshot.data!.docs;
                if (images.isEmpty) {
                  return Center(child: Text('ไม่มีรูปภาพผลงานร้านตัดผม'));
                }

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    final url = images[index]['url'];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.file(
                        File(url), // URL ที่เก็บใน Firestore เป็น path ของไฟล์รูปภาพในเครื่อง
                        fit: BoxFit.cover,
                        width: 200, // ขนาดความกว้างของรูปภาพ
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
