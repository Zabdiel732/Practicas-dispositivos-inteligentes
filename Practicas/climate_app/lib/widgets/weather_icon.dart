import 'package:flutter/material.dart';

class WeatherIcon extends StatelessWidget {
  final String condition;
  final double size;

  const WeatherIcon({
    Key? key, 
    required this.condition, 
    this.size = 80,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (condition.toLowerCase()) {
      case 'sunny':
        return Icon(Icons.sunny, size: size, color: Colors.orange);
      case 'rainy':
        return Icon(Icons.thunderstorm, size: size, color: Colors.blueGrey);
      case 'cloudy':
      default:
        return Icon(Icons.cloud, size: size, color: Colors.blue);
    }
  }
}