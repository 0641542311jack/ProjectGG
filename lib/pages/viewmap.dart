import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatefulWidget {
  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  late Position userLocation;
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<Position> _getLocation() async {
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
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    userLocation = await Geolocator.getCurrentPosition();
    return userLocation;
  }

  static final Marker _kGooglePlexMarker = Marker(
    markerId: MarkerId('_kGooglePlex'),
    infoWindow: InfoWindow(title: 'ร้านตัดผม'),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(
      16.250034,
      103.247939,
    ),
  );

  //เพิ่ม ตำแหน่ง Marker ใหม่
  // static final Marker _newMarker = Marker(
  //   markerId: MarkerId('_newMarker'),
  //   infoWindow: InfoWindow(title: 'ร้านกาแฟ'),
  //   icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
  //   position: LatLng(
  //     16.250524, // Latitude ของตำแหน่งใหม่
  //     103.250465, // Longitude ของตำแหน่งใหม่
  //   ),
  // );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ตำแหน่งร้านตัดผม'),
      ),
      body: Stack(children: [
        FutureBuilder(
          future: _getLocation(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return GoogleMap(
                mapType: MapType.hybrid,
                markers: {
                  _kGooglePlexMarker,
                 // _newMarker, // เพิ่ม Marker ใหม่ใน set นี้
                },
                onMapCreated: _onMapCreated,
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: LatLng(userLocation.latitude, userLocation.longitude),
                  zoom: 15,
                ),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                  ],
                ),
              );
            }
          },
        ),
        Positioned(
          bottom: 20,
          right: 150,
          child: FloatingActionButton.extended(
            onPressed: () {
              mapController.animateCamera(
                CameraUpdate.newLatLngZoom(LatLng(16.250034, 103.247939), 18),
              );
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(
                        'พิกัดร้านตัดผม \n${userLocation.latitude} long: ${userLocation.longitude}'),
                  );
                },
              );
            },
            label: Text(
              "ร้านตัดผม",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            icon: Icon(Icons.my_location),
          ),
        ),
      ]),
    );
  }
}

