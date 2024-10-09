import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewMap extends StatefulWidget {
  @override
  _ViewMapState createState() => _ViewMapState();
}

class _ViewMapState extends State<ViewMap> {
  Position? userLocation;
  late GoogleMapController mapController;
  Set<Marker> _markers = {};
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
            data['latitude']?.toDouble() ?? 0.0,
            data['longitude']?.toDouble() ?? 0.0,
          ),
          infoWindow: InfoWindow(title: data['title']),
        );
      }).toSet();
    });
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
                  onMapCreated: _onMapCreated,
                  myLocationEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(userLocation!.latitude, userLocation!.longitude),
                    zoom: 15,
                  ),
                )
              : Center(child: CircularProgressIndicator()), // แสดงแถบโหลดในขณะที่ดึงตำแหน่ง
        ],
      ),
    );
  }
}
