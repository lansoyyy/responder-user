import 'package:flutter/material.dart';

class FireTab extends StatelessWidget {
  const FireTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[50],
      appBar: AppBar(),
      body: Center(
        child: Image.asset(
          'assets/images/fire.PNG',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
