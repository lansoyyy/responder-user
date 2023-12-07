import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:responder/screens/pages/map_tab.dart';
import 'package:intl/intl.dart';
import '../../widgets/text_widget.dart';

class TrackingTab extends StatelessWidget {
  const TrackingTab({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Reports')
              .where('userId',
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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
                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MapTab(
                              docId: data.docs[index]['responder'],
                            )));
                  },
                  leading: const Icon(Icons.track_changes),
                  title: TextWidget(
                    text: data.docs[index]['caption'],
                    fontSize: 18,
                    fontFamily: 'Bold',
                  ),
                  subtitle: TextWidget(
                    text: data.docs[index]['name'],
                    fontSize: 14,
                    fontFamily: 'Medium',
                  ),
                  trailing: TextWidget(
                    text: DateFormat.yMMMd()
                        .add_jm()
                        .format(data.docs[index]['dateTime'].toDate()),
                    fontSize: 12,
                    fontFamily: 'Bold',
                  ),
                );
              },
            );
          }),
    );
  }
}
