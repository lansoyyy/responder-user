import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:responder/services/add_notif.dart';

Future addReport(name, contactnumber, address, caption, imageURL, lat, long,
    type, front, back) async {
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
    'responder': '',
    'day': DateTime.now().day,
    'month': DateTime.now().month,
    'year': DateTime.now().year,
    'type': type,
    'front': front,
    'back': back,
  };

  addNotif(name, contactnumber, address, caption, imageURL, lat, long);

  await docUser.set(json);
}
