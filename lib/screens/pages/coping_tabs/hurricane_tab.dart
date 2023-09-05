import 'package:flutter/material.dart';

class HurricaneTab extends StatelessWidget {
  const HurricaneTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(),
      body: Center(
        child: Image.asset(
          'assets/images/hurr.PNG',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
