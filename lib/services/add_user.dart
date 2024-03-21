import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future addUser(name, contactnumber, address, email, front, back) async {
  final docUser = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  final json = {
    'name': name,
    'address': address,
    'email': email,
    'profilePicture': 'https://cdn-icons-png.flaticon.com/256/149/149071.png',
    'status': 'Active',
    'userId': FirebaseAuth.instance.currentUser!.uid,
    'type': 'User',
    'contactnumber': contactnumber,
    'front': front,
    'back': back,
    'lat': 0,
    'long': 0
  };

  await docUser.set(json);
}
