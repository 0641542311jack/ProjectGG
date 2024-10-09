// import 'package:barberapp/pages/star_rating.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../services/database.dart';


// class Booking_User extends StatefulWidget {
//   final String service;
//   Booking_User({required this.service});

//   @override
//   State<Booking_User> createState() => _Booking_UserState();
// }

// class _Booking_UserState extends State<Booking_User> {
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
//                                   builder: (context) => StarRatingPopup( 
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
//                                   "รีวิว",
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
//     return Scaffold(
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



import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/database.dart';
import 'star_rating.dart'; // ตรวจสอบว่าไฟล์นี้มีอยู่จริงหรือไม่

class Booking_User extends StatefulWidget {
  final String service;

  Booking_User({required this.service});

  @override
  State<Booking_User> createState() => _BookingUserState();
}

class _BookingUserState extends State<Booking_User> {
  Stream<QuerySnapshot>? bookingStream;

  getBookings() {
    // ดึงข้อมูลการจองจาก Firebase Database
    bookingStream = FirebaseFirestore.instance.collection('Bookings').snapshots();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getBookings(); // เรียกการดึงข้อมูลเมื่อหน้าโหลด
  }

  Widget allBookings() {
    return StreamBuilder<QuerySnapshot>(
      stream: bookingStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text("คุณยังไม่ได้จองคิว",style: TextStyle(fontSize: 15),));
        }

        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data!.docs[index];
            return Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 4, 37, 72),
                      Color.fromARGB(255, 45, 84, 135),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: Image.network(
                            ds["Image"],
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Service :   " + ds["Service"],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Name :   " + ds["Username"],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Date :   " + ds["Date"],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Time :   " + ds["Time"],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        // ฟังก์ชันการให้รีวิว
                        showDialog(
                          context: context,
                          builder: (context) => StarRatingPopup(
                            bookingId: ds.id,
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 218, 118, 24),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "รีวิว",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () async {
                        // ฟังก์ชันการยกเลิกการจอง
                        await FirebaseFirestore.instance
                            .collection('Bookings')
                            .doc(ds.id)
                            .delete();
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 232, 7, 7),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "ยกเลิก",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
                child: Text(
              "All Bookings",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            )),
            SizedBox(height: 30),
            Expanded(child: allBookings()),
          ],
        ),
      ),
    );
  }
}
