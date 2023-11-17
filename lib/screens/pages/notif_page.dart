import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:responder/services/add_notif.dart';
import 'package:responder/widgets/text_widget.dart';

class NotifPage extends StatelessWidget {
  const NotifPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          text: 'Notifications',
          fontSize: 18,
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Notifs')
              .orderBy('dateTime', descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              print('error');
              return const Center(child: Text('Error'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Padding(
                padding: EdgeInsets.only(top: 50),
                child: Center(
                    child: CircularProgressIndicator(
                  color: Colors.black,
                )),
              );
            }

            final data = snapshot.requireData;
            return ListView.builder(
              itemCount: data.docs.length,
              itemBuilder: (context, index) {
                return data.docs[index]['status'] == 'Crisis'
                    ? ListTile(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text(
                                      'Confirmation',
                                      style: TextStyle(
                                          fontFamily: 'QBold',
                                          fontWeight: FontWeight.bold),
                                    ),
                                    content: const Text(
                                      'Are you sure you want to mark as safe?',
                                      style: TextStyle(fontFamily: 'QRegular'),
                                    ),
                                    actions: <Widget>[
                                      MaterialButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(true),
                                        child: const Text(
                                          'Close',
                                          style: TextStyle(
                                              fontFamily: 'QRegular',
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      StreamBuilder<DocumentSnapshot>(
                                          stream: userData,
                                          builder: (context,
                                              AsyncSnapshot<DocumentSnapshot>
                                                  snapshot) {
                                            if (!snapshot.hasData) {
                                              return const SizedBox();
                                            } else if (snapshot.hasError) {
                                              return const Center(
                                                  child: Text(
                                                      'Something went wrong'));
                                            } else if (snapshot
                                                    .connectionState ==
                                                ConnectionState.waiting) {
                                              return const SizedBox();
                                            }
                                            dynamic data = snapshot.data;
                                            return MaterialButton(
                                              onPressed: () async {
                                                addNotif(
                                                    data['name'],
                                                    data['contactnumber'],
                                                    data['address'],
                                                    'Marked as safe in ${data['address']}',
                                                    'imageURL',
                                                    0,
                                                    0);
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text(
                                                'Continue',
                                                style: TextStyle(
                                                    fontFamily: 'QRegular',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            );
                                          }),
                                    ],
                                  ));
                        },
                        leading: const Icon(
                          Icons.notifications,
                          color: Colors.red,
                        ),
                        title: TextWidget(
                            text:
                                '${data.docs[index]['name']} submitted a report: ${data.docs[index]['caption']}',
                            fontSize: 14),
                        subtitle: TextWidget(
                            text: data.docs[index]['address'], fontSize: 12),
                        trailing: const Icon(
                          Icons.pending,
                        ),
                      )
                    : ListTile(
                        leading: const Icon(Icons.notifications),
                        title: TextWidget(
                            text:
                                '${data.docs[index]['name']} submitted a report: ${data.docs[index]['caption']}',
                            fontSize: 14),
                        subtitle: TextWidget(
                            text: data.docs[index]['address'], fontSize: 12),
                        trailing: TextWidget(
                            text: data.docs[index]['status'], fontSize: 10),
                      );
              },
            );
          }),
    );
  }
}
