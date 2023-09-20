import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future addReport(
    name, contactnumber, address, caption, imageURL, lat, long) async {
  final docUser = FirebaseFirestore.instance.collection('Reports').doc();

  final json = {
    'name': name,
    'address': address,
    'caption': caption,
    'status': 'Pending',
    'userId': FirebaseAuth.instance.currentUser!.uid,
    'contactnumber': contactnumber,
    'imageURL': imageURL,
    'dateTime': DateTime.now(),
    'lat': lat,
    'long': long,
    'responder': ''
  };

  await docUser.set(json);
}
