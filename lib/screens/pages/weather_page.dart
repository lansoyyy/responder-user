import 'package:flutter/material.dart';

import '../../widgets/text_widget.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: TextWidget(
            text: 'WEATHER ALERT',
            fontSize: 18,
            color: Colors.white,
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  SizedBox(height: 20.0),
                  Icon(
                    Icons.warning,
                    color: Colors.red,
                    size: 150,
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Location: Cagayan De Oro',
                    style: TextStyle(fontSize: 16, fontFamily: 'QRegular'),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Weather Description: Windy',
                    style: TextStyle(fontSize: 16, fontFamily: 'QRegular'),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Temperature: 100°C',
                    style: TextStyle(fontSize: 16, fontFamily: 'QRegular'),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Pressure: 100 hPa',
                    style: TextStyle(fontSize: 16, fontFamily: 'QRegular'),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Humidity: 50%',
                    style: TextStyle(fontSize: 16, fontFamily: 'QRegular'),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Wind Speed: 20 m/s',
                    style: TextStyle(fontSize: 16, fontFamily: 'QRegular'),
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ));
  }
}
