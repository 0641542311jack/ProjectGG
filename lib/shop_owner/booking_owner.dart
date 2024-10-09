// import 'package:barberapp/services/database.dart';
// import 'package:barberapp/shop_owner/review_owner.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class BookingOwner extends StatefulWidget {
//    final String service;
//   BookingOwner({required this.service});

//   @override
//   State<BookingOwner> createState() => _BookingOwnerState();
// }

// class _BookingOwnerState extends State<BookingOwner> {
//   Stream? BookingStream;

//   getontheload() async {
//     BookingStream = await DatabaseMethods().getBookings();
//     setState(() {});
//   }

//   @override
//   void initState() {
//     getontheload();
//     super.initState();
//   }

//   Widget allBookings() {
//     return StreamBuilder(
//         stream: BookingStream,
//         builder: (context, AsyncSnapshot snapshot) {
//           return snapshot.hasData
//               ? ListView.builder(
//                   padding: EdgeInsets.zero,
//                   itemCount: snapshot.data.docs.length,
//                   scrollDirection: Axis.vertical,
//                   shrinkWrap: true,
//                   itemBuilder: (context, index) {
//                     DocumentSnapshot ds = snapshot.data.docs[index];
//                     return Material(
//                       elevation: 8,
//                       borderRadius: BorderRadius.circular(20),
//                       child: Container(
//                         padding: EdgeInsets.all(10),
//                         width: MediaQuery.of(context).size.width,
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(colors: [
//                             Color.fromARGB(255, 4, 37, 72),
//                             Color.fromARGB(255, 45, 84, 135),
//                           ]),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.circular(60),
//                                   child: Image.network(
//                                     ds["Image"],
//                                     height: 80,
//                                     width: 80,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 10),
//                             Text(
//                               "Service :   " + ds["Service"],
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             SizedBox(height: 5),
//                             Text(
//                               "Name :   " + ds["Username"],
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             SizedBox(height: 5),
//                             Text(
//                               "Date :   " + ds["Date"],
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             SizedBox(height: 5),
//                             Text(
//                               "Time :   " + ds["Time"],
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             SizedBox(height: 20),
//                             GestureDetector(
//                               onTap: () {
//                                 showDialog(
//                                   context: context,
//                                   builder: (context) => ReviewOwner(
//                                     bookingId: ds.id, 
//                                   ),
//                                 );
//                               },
//                               child: Container(
//                                 padding: EdgeInsets.all(10),
//                                 decoration: BoxDecoration(
//                                     color: Color.fromARGB(255, 218, 118, 24),
//                                     borderRadius: BorderRadius.circular(10)),
//                                 child: Text(
//                                   "ดูรีวิวลูกค้า",
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 10),
//                             GestureDetector(
//                               onTap: () async {
//                                 await DatabaseMethods().DeleteBooking(ds.id);
//                               },
//                               child: Container(
//                                 padding: EdgeInsets.all(10),
//                                 decoration: BoxDecoration(
//                                     color: Color.fromARGB(255, 232, 7, 7),
//                                     borderRadius: BorderRadius.circular(10)),
//                                 child: Text(
//                                   "ยกเลิก",
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(height: 20),
//                           ],
//                         ),
//                       ),
//                     );
//                   })
//               : Container();
//         });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       appBar: AppBar(),
//       body: Container(
//         margin: EdgeInsets.only(top: 10, left: 20, right: 20),
//         child: Column(
//           children: [
//             Center(
//                 child: Text(
//               "All Bookings",
//               style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold),
//             )),
//             SizedBox(height: 30),
//             Expanded(child: allBookings()),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:barberapp/services/database.dart';
import 'package:barberapp/shop_owner/review_owner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BookingOwner extends StatefulWidget {
  final String service;
  BookingOwner({required this.service});

  @override
  State<BookingOwner> createState() => _BookingOwnerState();
}

class _BookingOwnerState extends State<BookingOwner> {
  Stream? BookingStream;

  // โหลดข้อมูลการจองเมื่อเริ่มต้นแอป
  getontheload() async {
    BookingStream = await DatabaseMethods().getBookings();
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  // Helper function สำหรับเช็คว่าเป็นช่วงเช้าหรือบ่าย
  bool isMorning(String time) {
    final bookingTime = DateTime.parse("1970-01-01 $time:00");
    return bookingTime.hour < 12;
  }

  // สร้าง card สำหรับแสดงข้อมูลการจองแต่ละรายการ
  Widget bookingCard(DocumentSnapshot ds) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ds["Service"],
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("ชื่อ: ${ds["Username"]}", style: TextStyle(fontSize: 16)),
                    SizedBox(height: 4),
                    Text("วันที่: ${ds["Date"]}", style: TextStyle(fontSize: 16)),
                    SizedBox(height: 4),
                    Text("เวลา: ${ds["Time"]}", style: TextStyle(fontSize: 16)),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.star, color: Colors.orange),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => ReviewOwner(
                            bookingId: ds.id,
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: FaIcon(FontAwesomeIcons.trash, color: Colors.red),
                      onPressed: () async {
                        await DatabaseMethods().deleteBooking(ds.id); // เปลี่ยนชื่อที่นี่
                      },
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // แสดงรายการจองโดยแยกเป็นช่วงเช้าและบ่าย
  Widget bookingsList(AsyncSnapshot snapshot, bool morning) {
    var filteredDocs = snapshot.data.docs.where((DocumentSnapshot ds) {
      String time = ds["Time"];
      return morning ? isMorning(time) : !isMorning(time);
    }).toList();

    if (filteredDocs.isEmpty) {
      return Center(
        child: Text(
          morning ? 'ไม่มีการจองในช่วงเช้า' : 'ไม่มีการจองในช่วงบ่าย',
          style: TextStyle(color: Colors.grey, fontSize: 18),
        ),
      );
    } else {
      return ListView(
        children: filteredDocs.map<Widget>((DocumentSnapshot ds) {
          return bookingCard(ds);
        }).toList(),
      );
    }
  }

  // รวมข้อมูลการจองทั้งหมดในหน้าจอเดียว
  Widget allBookings() {
    return StreamBuilder(
      stream: BookingStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Column(
            children: [
              Text(
                "การจองช่วงเช้า",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Expanded(child: bookingsList(snapshot, true)),
              SizedBox(height: 20),
              Text(
                "การจองช่วงบ่าย",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Expanded(child: bookingsList(snapshot, false)),
            ],
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("การจองทั้งหมด", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            SizedBox(height: 10),
            Expanded(child: allBookings()),
          ],
        ),
      ),
    );
  }
}

