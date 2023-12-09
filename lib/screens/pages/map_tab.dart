import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../widgets/text_widget.dart';

class MapTab extends StatefulWidget {
  String? docId;

  String? id;

  MapTab({super.key, required this.docId, required this.id});

  @override
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    determinePosition();

    getMyReports();
    Geolocator.getCurrentPosition().then((position) {
      setState(() {});
      setState(() {
        lat = position.latitude;
        long = position.longitude;
        hasloaded = true;
      });
      setState(() {});
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
      markerId: MarkerId(userData['name']),
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
        .doc(widget.id)
        .get()
        .then((DocumentSnapshot querySnapshot) async {
      print(querySnapshot.data());
      addMarker(querySnapshot.data());
    });

    setState(() {});
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.docId)
        .snapshots();
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
          ? Column(
              children: [
                Expanded(
                  child: SizedBox(
                    child: GoogleMap(
                      markers: markers,
                      mapType: MapType.normal,
                      initialCameraPosition: kGooglePlex,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                    ),
                  ),
                ),
                widget.docId != ''
                    ? StreamBuilder<DocumentSnapshot>(
                        stream: userData,
                        builder: (context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return const SizedBox();
                          } else if (snapshot.hasError) {
                            return const Center(
                                child: Text('Something went wrong'));
                          } else if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const SizedBox();
                          }
                          dynamic data = snapshot.data;
                          return Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 150,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                      text: 'Responder:',
                                      fontSize: 18,
                                      fontFamily: 'Bold',
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.account_circle,
                                          size: 50,
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextWidget(
                                              text: data['name'],
                                              fontSize: 16,
                                            ),
                                            TextWidget(
                                              text: data['contactnumber'],
                                              fontSize: 16,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        })
                    : const SizedBox()
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
