// import 'package:cloud_firestore/cloud_firestore.dart';

// class DatabaseMethods {
//   Future addUserDetails(Map<String, dynamic> userInfoMap, String id) async {
//     return await FirebaseFirestore.instance
//         .collection("users")
//         .doc(id)
//         .set(userInfoMap);
//   }

//   Future addUserBooking(Map<String, dynamic> userInfoMap) async {
//     return await FirebaseFirestore.instance
//         .collection("Booking")
//         .add(userInfoMap);
//   }

//   Future<Stream<QuerySnapshot>> getBookings() async {
//     return await FirebaseFirestore.instance.collection("Booking").snapshots();
//   }

//  Future DeleteBooking(String id) async {
//     return await FirebaseFirestore.instance
//         .collection("Booking")
//         .doc(id)
//         .delete();
//   }
// Future<void> updateUserDetails(Map<String, dynamic> userInfoMap, String userId) async {
//     try {
//       await FirebaseFirestore.instance.collection("users").doc(userId).update(userInfoMap);
//       print("User details updated in Firestore");
//     } catch (e) {
//       print("Error updating user details: $e");
//     }
//   }
//   // updateUserDetails(Map<String, dynamic> userInfoMap, String userId) {}
  
// }


import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  // เพิ่มรายละเอียดผู้ใช้
  Future<void> addUserDetails(Map<String, dynamic> userInfoMap, String id) async {
    try {
      await FirebaseFirestore.instance.collection("users").doc(id).set(userInfoMap);
      print("User details added successfully.");
    } catch (e) {
      print("Error adding user details: $e");
    }
  }

  // เพิ่มการจองของผู้ใช้
  Future<void> addUserBooking(Map<String, dynamic> bookingInfoMap) async {
    try {
      await FirebaseFirestore.instance.collection("Bookings").add(bookingInfoMap); // แก้ชื่อคอลเลกชันที่นี่
      print("User booking added successfully.");
    } catch (e) {
      print("Error adding user booking: $e");
    }
  }

  // ดึงข้อมูลการจองทั้งหมด
  Future<Stream<QuerySnapshot>> getBookings() async {
    return FirebaseFirestore.instance.collection("Bookings").snapshots(); // แก้ชื่อคอลเลกชันที่นี่
  }

  // ลบการจอง
  Future<void> deleteBooking(String id) async {
    try {
      await FirebaseFirestore.instance.collection("Bookings").doc(id).delete(); // แก้ชื่อคอลเลกชันที่นี่
      print("Booking deleted successfully.");
    } catch (e) {
      print("Error deleting booking: $e");
    }
  }

  // อัปเดตข้อมูลผู้ใช้
  Future<void> updateUserDetails(Map<String, dynamic> userInfoMap, String userId) async {
    try {
      await FirebaseFirestore.instance.collection("users").doc(userId).update(userInfoMap);
      print("User details updated in Firestore");
    } catch (e) {
      print("Error updating user details: $e");
    }
  }
}


