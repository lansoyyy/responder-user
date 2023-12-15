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
          padding: const EdgeInsets.all(0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const HurricaneTab()));
                      },
                      child:
                          cardWidget('assets/images/image 2.png', 'Hurricane')),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const FloodTab()));
                      },
                      child: cardWidget('assets/images/flood.png', 'Flood')),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const EarthquakeTab()));
                      },
                      child: cardWidget(
                          'assets/images/earthquake.png', 'Earthquake')),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const FireTab()));
                      },
                      child: cardWidget('assets/images/fire 1.png', 'Fire')),
                  // GestureDetector(
                  //      onTap: () {

                  //    Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => const FloodTab()));
                  //   },
                  //   child: cardWidget('assets/images/landslide.png', 'Landslide')),
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [],
              // ),
            ],
          )),
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

  Widget cardWidget(String path, String number) {
    return Container(
      width: 175,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(
          color: Colors.black,
        ),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              path,
              height: 60,
            ),
            const SizedBox(
              height: 10,
            ),
            TextWidget(
              text: number,
              fontSize: 24,
              fontFamily: 'Bold',
            ),
          ],
        ),
      ),
    );
  }
}
