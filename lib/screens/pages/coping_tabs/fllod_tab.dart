import 'package:flutter/material.dart';

class FloodTab extends StatelessWidget {
  const FloodTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: AppBar(),
      body: Center(
        child: Image.asset(
          'assets/images/flood1.PNG',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
