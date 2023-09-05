import 'package:flutter/material.dart';
import 'package:responder/screens/pages/coping_tabs/earthquake_tab.dart';
import 'package:responder/screens/pages/coping_tabs/fire_tab.dart';
import 'package:responder/screens/pages/coping_tabs/fllod_tab.dart';
import 'package:responder/screens/pages/coping_tabs/hurricane_tab.dart';

import '../../widgets/text_widget.dart';

class CopingMainScreen extends StatelessWidget {
  const CopingMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: TextWidget(text: 'INCASE OF:', fontSize: 18),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HurricaneTab()));
                },
                child: card('HURRICANE', Icons.warning)),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const EarthquakeTab()));
                },
                child: card('EARTHQUAKE', Icons.warning)),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const FireTab()));
                },
                child: card('FIRE', Icons.warning)),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const FloodTab()));
                },
                child: card('FLOOD', Icons.warning)),
          ],
        ),
      ),
    );
  }

  Widget card(String title, IconData icon) {
    return Container(
      height: 75,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.white,
          ),
          title: TextWidget(
            text: title,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
