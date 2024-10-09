// import 'package:barberapp/services/database.dart';
// import 'package:barberapp/services/shared_pref.dart';
// import 'package:card_swiper/card_swiper.dart';
// import 'package:flutter/material.dart';

// class Booking extends StatefulWidget {
//   String service;
//   Booking({required this.service});

//   @override
//   State<Booking> createState() => _BookingState();
// }

// class _BookingState extends State<Booking> {
//   String? name, image, email;

//   getthedatafromsharedpref() async {
//     name = await SharedpreferenceHelper().getUserName();
//     image = await SharedpreferenceHelper().getUserImage();
//     email = await SharedpreferenceHelper().getUserEmail();
//     setState(() {});
//   }

//   getontheload() async {
//     await getthedatafromsharedpref();
//     setState(() {});
//   }

//   @override
//   void initState() {
//     getontheload();
//     super.initState();
//   }

//   DateTime _selectedDate = DateTime.now();

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//         context: context,
//         initialDate: _selectedDate,
//         firstDate: DateTime(2024),
//         lastDate: DateTime(2025));
//     if (picked != null && picked != _selectedDate) {
//       setState(() {
//         _selectedDate = picked;
//       });
//     }
//   }

//   TimeOfDay _selectedTime = TimeOfDay.now();

//   Future<void> _selectTime(BuildContext context) async {
//     final TimeOfDay? picked =
//         await showTimePicker(context: context, initialTime: _selectedTime);
//     if (picked != null && picked != _selectedTime) {
//       setState(() {
//         _selectedTime = picked;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "เลือกการจองของคุณ",
//           style: TextStyle(color: Colors.white), // สีตัวหนังสือ
//         ),
//         backgroundColor: const Color.fromARGB(255, 4, 37, 72), // สีของ AppBar
//         iconTheme: IconThemeData(
//           color: Colors.white, // สีของลูกศรย้อนกลับ
//         ),
//       ),
//       backgroundColor: Color.fromARGB(255, 4, 37, 72),
//       body: SingleChildScrollView(
//         child: Container(
//           margin: EdgeInsets.only(left: 5, right: 5),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: 220,
//                 child: Swiper(
//                   itemBuilder: (BuildContext context, int index) {
//                     List<Image> images = [
//                       Image.asset("images/bbshop.png", fit: BoxFit.fill),
//                       Image.asset("images/shop1.png", fit: BoxFit.fill),
//                       Image.asset("images/shop2.png", fit: BoxFit.fill),
//                       Image.asset("images/shop3.png", fit: BoxFit.fill),

//                     ];

//                     return images[index];
//                   },
//                   itemCount: 4,
//                   viewportFraction: 0.8,
//                   scale: 0.9,
//                 ),
//               ),
//               SizedBox(
//                 height: 40,
//               ),
//               Text(
//                 widget.service,
//                 style: TextStyle(
//                     color: Colors.orange,
//                     fontSize: 40,
//                     fontWeight: FontWeight.bold),
//               ),
//               SizedBox(
//                 height: 40,
//               ),
//               Container(
//                 padding: EdgeInsets.only(top: 2, bottom: 2),
//                 decoration: BoxDecoration(
//                     color: Color.fromARGB(255, 50, 83, 125),
//                     borderRadius: BorderRadius.circular(20),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.6), // สีของเงา
//                         spreadRadius: 5, // การกระจายของเงา
//                         blurRadius: 20, // การเบลอของเงา
//                         offset: Offset(0, 3), // ตำแหน่งของเงา
//                       )
//                     ]),
//                 width: MediaQuery.of(context).size.width,
//                 child: Column(
//                   children: [
//                     Text(
//                       "Set a Date",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 30,
//                           fontWeight: FontWeight.w500),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             _selectDate(context);
//                           },
//                           child: Icon(
//                             Icons.calendar_month,
//                             color: Colors.white,
//                             size: 50,
//                           ),
//                         ),
//                         SizedBox(
//                           width: 20,
//                         ),
//                         Text(
//                           "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 30,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 25,
//               ),
//               Container(
//                 padding: EdgeInsets.only(top: 2, bottom: 2),
//                 decoration: BoxDecoration(
//                     color: Color.fromARGB(255, 50, 83, 125),
//                     borderRadius: BorderRadius.circular(20),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.6), // สีของเงา
//                         spreadRadius: 5, // การกระจายของเงา
//                         blurRadius: 20, // การเบลอของเงา
//                         offset: Offset(0, 3), // ตำแหน่งของเงา
//                       )
//                     ]),
//                 width: MediaQuery.of(context).size.width,
//                 child: Column(
//                   children: [
//                     Text(
//                       "Set a Time",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 30,
//                           fontWeight: FontWeight.w500),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             _selectTime(context);
//                           },
//                           child: Icon(
//                             Icons.alarm,
//                             color: Colors.white,
//                             size: 50,
//                           ),
//                         ),
//                         SizedBox(
//                           width: 20,
//                         ),
//                         Text(
//                           _selectedTime.format(context),
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 30,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 55,
//               ),
//               GestureDetector(
//                 onTap: () async {
//                   Map<String, dynamic> userBookingmap = {
//                     "Service": widget.service,
//                     "Date":
//                         "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}"
//                             .toString(),
//                     "Time": _selectedTime.format(context).toString(),
//                     "Username": name,
//                     "Image": image,
//                     "Email": email,
//                   };
//                   await DatabaseMethods()
//                       .addUserBooking(userBookingmap)
//                       .then((value) {
//                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                         content: Text(
//                       "บริการจองสำเร็จแล้ว",
//                       style: TextStyle(fontSize: 20),
//                     )));
//                   });
//                 },
//                 child: Container(
//                   width: MediaQuery.of(context).size.width,
//                   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//                   decoration: BoxDecoration(
//                       color: Color(0xFFfe8f33),
//                       borderRadius: BorderRadius.circular(20),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.6), // สีของเงา
//                           spreadRadius: 5, // การกระจายของเงา
//                           blurRadius: 20, // การเบลอของเงา
//                           offset: Offset(0, 3), // ตำแหน่งของเงา
//                         )
//                       ]),
//                   child: Center(
//                     child: Text(
//                       "ยืนยัน",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // ใช้สำหรับ Firebase
import 'package:barberapp/services/shared_pref.dart';
import 'package:card_swiper/card_swiper.dart';

class Booking extends StatefulWidget {
  String service;
  Booking({required this.service});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  String? name, image, email;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  // Get user data from shared preferences
  getthedatafromsharedpref() async {
    name = await SharedpreferenceHelper().getUserName();
    image = await SharedpreferenceHelper().getUserImage();
    email = await SharedpreferenceHelper().getUserEmail();
    setState(() {});
  }

  // Initialize and load data
  getontheload() async {
    await getthedatafromsharedpref();
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  // Function to select a date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2024),
        lastDate: DateTime(2025));
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Function to select a time
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: _selectedTime);
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  // Function to get the number of bookings in Firebase for a given date and hour
  Future<int> getBookingCountByHour(String date, int hour) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Bookings')
        .where('Date', isEqualTo: date)
        .where('Hour', isEqualTo: hour) // ตรวจสอบการจองที่ชั่วโมงเดียวกัน
        .get();

    return snapshot.docs.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "เลือกการจองของคุณ",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 4, 37, 72), // สีของ AppBar
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      backgroundColor: Color.fromARGB(255, 4, 37, 72),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 5, right: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
                child: Image.asset(
                  "images/1barber.png",
                  fit: BoxFit.fill,
                ),
              ),

              SizedBox(height: 40),
              Text(
                widget.service,
                style: TextStyle(
                    color: Colors.orange,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              // เลือกวันที่
              Container(
                padding: EdgeInsets.only(top: 2, bottom: 2),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 50, 83, 125),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.6),
                        spreadRadius: 5,
                        blurRadius: 20,
                        offset: Offset(0, 3),
                      )
                    ]),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Text(
                      "Set a Date",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _selectDate(context);
                          },
                          child: Icon(
                            Icons.calendar_month,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 25),
              // เลือกเวลา
              Container(
                padding: EdgeInsets.only(top: 2, bottom: 2),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 50, 83, 125),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.6),
                        spreadRadius: 5,
                        blurRadius: 20,
                        offset: Offset(0, 3),
                      )
                    ]),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Text(
                      "Set a Time",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _selectTime(context);
                          },
                          child: Icon(
                            Icons.alarm,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          _selectedTime.format(context),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 55),
              // ปุ่มยืนยันการจอง
              GestureDetector(
                onTap: () async {
                  String selectedDate =
                      "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}";
                  int selectedHour =
                      _selectedTime.hour; // เก็บค่า hour ที่เลือก

                  // ตรวจสอบจำนวนการจองที่มีในช่วงเวลานั้น
                  int bookingCount =
                      await getBookingCountByHour(selectedDate, selectedHour);

                  if (bookingCount < 2) {
                    Map<String, dynamic> userBookingmap = {
                      "Service": widget.service,
                      "Date": selectedDate,
                      "Time": _selectedTime.format(context),
                      "Hour": selectedHour, // เก็บชั่วโมงที่เลือก
                      "Username": name,
                      "Image": image,
                      "Email": email,
                    };

                    await FirebaseFirestore.instance
                        .collection('Bookings')
                        .add(userBookingmap)
                        .then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          "บริการจองสำเร็จแล้ว",
                          style: TextStyle(fontSize: 20),
                        ),
                        backgroundColor: Colors.green,
                      ));
                    });
                  } else {
                    // แสดงข้อความเมื่อการจองเกิน 2 ครั้งในชั่วโมงนั้น
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        "ขออภัย ช่วงเวลานี้เต็มแล้ว กรุณาเลือกชั่วโมงอื่น",
                        style: TextStyle(fontSize: 20),
                      ),
                      backgroundColor: Colors.red, // เปลี่ยนเป็นสีที่คุณต้องการ
                    ));
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  decoration: BoxDecoration(
                      color: Color(0xFFfe8f33),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.6),
                          spreadRadius: 5,
                          blurRadius: 20,
                          offset: Offset(0, 3),
                        )
                      ]),
                  child: Center(
                    child: Text(
                      "ยืนยัน",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
