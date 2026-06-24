import 'package:flutter/material.dart';
import '../widgets/weather_icon.dart';
import 'search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isLandscape = width > 600; // Detecta si está en horizontal

    return Scaffold(
      appBar: AppBar(
        title: const Text('Clima Actual'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade100,
      ),
      body: Center(
        child: SingleChildScrollView( // Previene desbordamiento en pantallas chicas
          padding: const EdgeInsets.all(16.0),
          child: isLandscape 
            ? Row( // Si está en Landscape, ponemos los datos lado a lado
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const WeatherIcon(condition: 'cloudy', size: 140),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: _buildWeatherDetails(),
                  ),
                ],
              )
            : Column( // Si está en Portrait, se muestra en vertical
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const WeatherIcon(condition: 'cloudy', size: 120),
                  const SizedBox(height: 16),
                  ..._buildWeatherDetails(),
                ],
              ),
        ),
      ),
    );
  }

  // Lista de widgets para no duplicar código entre orientaciones
  List<Widget> _buildWeatherDetails() {
    return [
      const Text(
        '24°C',
        style: TextStyle(fontSize: 72, fontWeight: FontWeight.bold, color: Colors.blue),
      ),
      const SizedBox(height: 8),
      const Text(
        'Santiago de Querétaro',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
      ),
      const SizedBox(height: 16),
      const Text(
        'Humedad: 65% | Viento: 12 km/h',
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
      const SizedBox(height: 32),
      Builder(
        builder: (context) => ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchScreen()),
            );
          },
          icon: const Icon(Icons.search),
          label: const Text('Buscar Ciudades'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
      ),
    ];
  }
}