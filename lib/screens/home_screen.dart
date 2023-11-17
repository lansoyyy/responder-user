import 'package:flutter/material.dart';
import 'package:responder/screens/pages/add_report_page.dart';
import 'package:responder/screens/pages/coping_main_page.dart';
import 'package:responder/screens/pages/first_aid_page.dart';
import 'package:responder/screens/pages/notif_page.dart';
import 'package:responder/screens/pages/tracking_tab.dart';
import 'package:responder/screens/pages/weather_page.dart';

import '../widgets/text_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.account_circle_outlined,
        ),
        title: TextWidget(
          text: 'Home',
          fontSize: 18,
          color: Colors.white,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const NotifPage()));
            },
            icon: const Icon(
              Icons.notifications,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AddReportPage()));
                },
                child: card('REPORT ACCIDENT', Icons.report)),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const CopingMainScreen()));
                },
                child: card('DISASTER COPING TIPS', Icons.warning)),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const FirstAidScreen()));
                },
                child: card('LEARN FIRST AID', Icons.medical_information)),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const WeatherScreen()));
                },
                child: card('WEATHER ALERTS', Icons.sunny)),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const TrackingTab()));
                },
                child: card('TRACKING', Icons.map_outlined)),
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
