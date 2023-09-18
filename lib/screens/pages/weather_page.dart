import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import '../../widgets/text_widget.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void initState() {
    super.initState();
    addMarker();
  }

  bool hasLoaded = false;

  var weatherDescription;
  var temperatureKelvin;
  var temperatureCelsius;
  var pressure;
  var humidity;
  var windSpeed;

  addMarker() {
    Geolocator.getCurrentPosition().then((position) async {
      var uri =
          'https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=67a96ca939095cc12748c226c7d3851c';

      var response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        weatherDescription = data['weather'][0]['description'];
        temperatureKelvin = data['main']['temp'];
        temperatureCelsius = temperatureKelvin - 273.15;
        pressure = data['main']['pressure'];
        humidity = data['main']['humidity'];
        windSpeed = data['wind']['speed'];
      }

      setState(() {
        hasLoaded = true;
      });
    }).catchError((error) {
      print('Error getting location: $error');
    });
  }

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
        body: hasLoaded
            ? Container(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20.0),
                        const Icon(
                          Icons.warning,
                          color: Colors.red,
                          size: 150,
                        ),
                        const SizedBox(height: 16.0),
                        Text(
                          'Weather Description: $weatherDescription',
                          style: const TextStyle(
                              fontSize: 16, fontFamily: 'QRegular'),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Temperature: $temperatureCelsius°C',
                          style: const TextStyle(
                              fontSize: 16, fontFamily: 'QRegular'),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Pressure: $pressure hPa',
                          style: const TextStyle(
                              fontSize: 16, fontFamily: 'QRegular'),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Humidity: $humidity%',
                          style: const TextStyle(
                              fontSize: 16, fontFamily: 'QRegular'),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Wind Speed: $windSpeed m/s',
                          style: const TextStyle(
                              fontSize: 16, fontFamily: 'QRegular'),
                        ),
                        const SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}
