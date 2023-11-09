import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../widgets/text_widget.dart';

class MapTab extends StatefulWidget {
  String? docId;

  MapTab({super.key, required this.docId});

  @override
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getMyReports();
    Geolocator.getCurrentPosition().then((position) {
      setState(() {
        lat = position.latitude;
        long = position.longitude;
        hasloaded = true;
      });
    }).catchError((error) {
      print('Error getting location: $error');
    });
  }

  bool hasloaded = false;
  GoogleMapController? mapController;

  double lat = 0;
  double long = 0;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Set<Marker> markers = {};

  addMarker(userData) async {
    markers.add(Marker(
      markerId: MarkerId(userData.id),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(userData['lat'], userData['long']),
      infoWindow: InfoWindow(
        title: userData['caption'],
        snippet: 'Status: ${userData['status']}',
      ),
    ));
  }

  getMyReports() async {
    FirebaseFirestore.instance
        .collection('Reports')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('status', isEqualTo: 'Pending')
        .get()
        .then((QuerySnapshot querySnapshot) async {
      for (var doc in querySnapshot.docs) {
        addMarker(doc);
      }
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition kGooglePlex = CameraPosition(
      target: LatLng(lat, long),
      zoom: 14.4746,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: TextWidget(
          text: 'TRACKING',
          fontSize: 18,
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: hasloaded
          ? GoogleMap(
              markers: markers,
              mapType: MapType.normal,
              initialCameraPosition: kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
