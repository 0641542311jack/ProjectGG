import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShopViewer extends StatefulWidget {
  @override
  _ShopViewerState createState() => _ShopViewerState();
}

class _ShopViewerState extends State<ShopViewer> {
  List<String> _imageUrls = [];

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('images').get();
    setState(() {
      _imageUrls = snapshot.docs.map((doc) => doc['url'] as String).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color.fromARGB(255, 4, 37, 72),
      appBar: AppBar(
        title: Text(
          'เกี่ยวกับร้านตัดผม',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor:
            const Color.fromARGB(255, 4, 37, 72), // เปลี่ยนสี AppBar
        iconTheme: IconThemeData(
          color: Colors.white, // เปลี่ยนสีลูกศรย้อนกลับเป็นสีขาว
        ),
      ),
      body: _imageUrls.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _imageUrls.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 1.0), // ระยะห่างระหว่างภาพ
                  child: Image.network(
                    _imageUrls[index],
                    fit: BoxFit.cover,
                    width: double.infinity, // กำหนดให้กว้างเต็มที่
                    height: 200, // ความสูงของภาพ
                  ),
                );
              },
            ),
    );
  }
}
