import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Hairshow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 4, 37, 72),
      appBar: AppBar(
        title: Text(
          'ข้อมูลทรงผม',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor:
            const Color.fromARGB(255, 4, 37, 72), // เปลี่ยนสี AppBar
        iconTheme: IconThemeData(
          color: Colors.white, // เปลี่ยนสีลูกศรย้อนกลับเป็นสีขาว
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('shopData')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var document = snapshot.data!.docs[index];
              var data = document.data() as Map<String, dynamic>;

              return Card(
                // ใช้ Card เพื่อเพิ่มความสวยงาม
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                elevation: 4, // เพิ่มเงาให้กับ Card
                child: Padding(
                  padding: const EdgeInsets.all(16.0), // เพิ่ม Padding
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // แสดงรูปภาพ
                      data['imageUrl'] != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  8.0), // ทำให้มุมของรูปภาพกลม
                              child: Image.network(
                                data['imageUrl'],
                                height: 150,
                                width: double.infinity, // ทำให้กว้างเต็มที่
                                fit: BoxFit
                                    .fitHeight, // ปรับขนาดให้พอดีกับ Container
                              ),
                            )
                          : Container(),
                      SizedBox(
                          height: 10), // เพิ่มช่องว่างระหว่างรูปภาพและข้อความ
                      // แสดงชื่อ
                      Text(
                        data['name'] ?? 'ไม่มีชื่อ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold, // ทำให้ตัวหนา
                          color: Colors.teal, // เปลี่ยนสีข้อความ
                        ),
                      ),
                      SizedBox(height: 5), // เพิ่มช่องว่าง
                      // แสดงคำอธิบาย
                      Text(
                        data['description'] ?? 'ไม่มีคำอธิบาย',
                        style: TextStyle(color: Colors.grey[600]), // เปลี่ยนสี
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
