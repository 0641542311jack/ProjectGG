import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MapsPage extends StatefulWidget {
  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  Position? userLocation; // เปลี่ยนให้เป็น nullable
  late GoogleMapController mapController;
  Set<Marker> _markers = {};
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? selectedMarkerId; // ตัวแปรสำหรับเก็บ ID ของหมุดที่เลือก

  @override
  void initState() {
    super.initState();
    _getLocation(); // ดึงตำแหน่งปัจจุบัน
    _loadMarkersFromFirebase(); // โหลด markers ที่บันทึกจาก Firebase
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  // ฟังก์ชันเพื่อดึงตำแหน่งปัจจุบัน
  Future<void> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    userLocation = await Geolocator.getCurrentPosition();
    setState(() {}); // เรียกใช้ setState เพื่ออัพเดตแผนที่
  }

  // โหลด markers จาก Firebase
  Future<void> _loadMarkersFromFirebase() async {
    final markerCollection = await _firestore.collection('markers').get();
    setState(() {
      _markers = markerCollection.docs.map((doc) {
        final data = doc.data();
        return Marker(
          markerId: MarkerId(doc.id),
          position: LatLng(
            data['latitude']?.toDouble() ?? 0.0, // ปรับให้แน่ใจว่าเป็น double
            data['longitude']?.toDouble() ?? 0.0, // ปรับให้แน่ใจว่าเป็น double
          ),
          infoWindow: InfoWindow(title: data['title']),
          onTap: () {
            setState(() {
              selectedMarkerId = doc.id; // ตั้งค่า selectedMarkerId เมื่อกดที่หมุด
            });
          },
          draggable: true, // เพิ่มให้สามารถลากหมุดได้
          onDragEnd: (newPosition) {
            _updateMarkerPositionInFirebase(doc.id, newPosition);
          },
        );
      }).toSet();
    });
  }

  // บันทึก marker ลง Firebase
  Future<void> _saveMarkerToFirebase(LatLng position, String title) async {
    await _firestore.collection('markers').add({
      'latitude': position.latitude,
      'longitude': position.longitude,
      'title': title, // เพิ่มชื่อหมุด
    });
    _loadMarkersFromFirebase();
  }

  // อัปเดตตำแหน่ง marker ใน Firebase
  Future<void> _updateMarkerPositionInFirebase(String markerId, LatLng newPosition) async {
    await _firestore.collection('markers').doc(markerId).update({
      'latitude': newPosition.latitude,
      'longitude': newPosition.longitude,
    });
    _loadMarkersFromFirebase();
  }

  // ลบ marker จาก Firebase
  Future<void> _deleteMarkerFromFirebase(String markerId) async {
    await _firestore.collection('markers').doc(markerId).delete();
    _loadMarkersFromFirebase();
    setState(() {
      selectedMarkerId = null; // รีเซ็ต selectedMarkerId หลังจากลบ
    });
  }

  // แสดง dialog ให้ป้อนชื่อหมุด
  void _showAddMarkerDialog(LatLng position) {
    final titleController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Marker'),
          content: TextField(
            controller: titleController,
            decoration: InputDecoration(hintText: 'Enter marker name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                String title = titleController.text;
                if (title.isNotEmpty) {
                  _saveMarkerToFirebase(position, title); // บันทึกหมุดพร้อมชื่อ
                  Navigator.of(context).pop();
                }
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ตำแหน่งร้านตัดผม'),
      ),
      body: Stack(
        children: [
          userLocation != null
              ? GoogleMap(
                  mapType: MapType.hybrid,
                  markers: _markers,
                  onTap: (LatLng position) {
                    _showAddMarkerDialog(position); // แสดง dialog เพื่อป้อนชื่อหมุด
                  },
                  onMapCreated: _onMapCreated,
                  myLocationEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(userLocation!.latitude, userLocation!.longitude),
                    zoom: 15,
                  ),
                )
              : Center(child: CircularProgressIndicator()), // แสดงแถบโหลดในขณะที่ดึงตำแหน่ง
          Positioned(
            bottom: 100, // เลื่อนขึ้นจากขอบล่าง
            right: 16,
            child: selectedMarkerId != null // แสดงปุ่มลบเมื่อมีการเลือกหมุด
                ? ElevatedButton(
                    onPressed: () {
                      if (selectedMarkerId != null) {
                        _deleteMarkerFromFirebase(selectedMarkerId!);
                      }
                    },
                    child: Text('ลบหมุด'),
                  )
                : Container(), // ไม่แสดงอะไรถ้าไม่มีการเลือกหมุด
          ),
        
        ],
      ),
    );
  }
}