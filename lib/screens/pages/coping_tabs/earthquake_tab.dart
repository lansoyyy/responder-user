import 'package:flutter/material.dart';

class EarthquakeTab extends StatelessWidget {
  const EarthquakeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(),
      body: Center(
        child: Image.asset(
          'assets/images/earth.PNG',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
