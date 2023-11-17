import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:responder/widgets/drawer_widget.dart';
import 'package:responder/widgets/text_widget.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  List contacts = [
    {'name': 'Baranggay Hall', 'contact': '09090104355'},
    {'name': 'BDRRMC Councilor', 'contact': '09090104355'},
    {'name': 'BDRRMC Head', 'contact': '09090104355'},
    {'name': 'Police', 'contact': '09090104355'},
    {'name': 'Firestation', 'contact': '09090104355'},
    {'name': 'Emergency', 'contact': '911'},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const DrawerWidget(),
        appBar: AppBar(
          title: TextWidget(
            text: 'Contact Page',
            fontSize: 18,
            color: Colors.white,
          ),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(Icons.phone),
              title: TextWidget(
                  text:
                      '${contacts[index]['name']}: ${contacts[index]['contact']}',
                  fontSize: 14),
            );
          },
        ));
  }
}
