import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responder/widgets/text_widget.dart';

class HistoryReportTab extends StatelessWidget {
  const HistoryReportTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: TextWidget(
          text: 'MY HISTORY',
          fontSize: 18,
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Reports')
                    .where('userId',
                        isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
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
                  return Expanded(
                    child: ListView.builder(
                      itemCount: data.docs.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {},
                          leading: const Icon(
                            Icons.account_circle,
                          ),
                          title: TextWidget(
                              text: data.docs[index]['name'] +
                                  ' - ' +
                                  data.docs[index]['status'],
                              fontSize: 12),
                          subtitle: data.docs[index]['responder'] == ''
                              ? const SizedBox()
                              : StreamBuilder<DocumentSnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('Users')
                                      .doc(data.docs[index]['responder'])
                                      .snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<DocumentSnapshot>
                                          snapshot) {
                                    if (!snapshot.hasData) {
                                      return const SizedBox();
                                    } else if (snapshot.hasError) {
                                      return const Center(
                                          child: Text('Something went wrong'));
                                    } else if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const SizedBox();
                                    }
                                    dynamic data12 = snapshot.data;
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextWidget(
                                          text: data.docs[index]['caption'],
                                          fontSize: 14,
                                          fontFamily: 'Bold',
                                        ),
                                        data.docs[index]['responder'] != ''
                                            ? TextWidget(
                                                text:
                                                    'Responder: ${data12['name']}',
                                                fontSize: 12,
                                                fontFamily: 'Medium',
                                              )
                                            : const SizedBox(),
                                        TextWidget(
                                          text: DateFormat.yMMMd()
                                              .add_jm()
                                              .format(data.docs[index]
                                                      ['dateTime']
                                                  .toDate()),
                                          fontSize: 12,
                                          fontFamily: 'Bold',
                                        ),
                                      ],
                                    );
                                  }),
                        );
                      },
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
