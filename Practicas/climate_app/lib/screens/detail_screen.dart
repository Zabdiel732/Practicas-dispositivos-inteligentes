import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String city;

  const DetailScreen({Key? key, required this.city}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Datos simulados para el pronóstico
    final List<Map<String, String>> forecast = [
      {'day': 'Lun', 'temp': '24°C', 'icon': '☀️'},
      {'day': 'Mar', 'temp': '26°C', 'icon': '☀️'},
      {'day': 'Mié', 'temp': '20°C', 'icon': '🌧️'},
      {'day': 'Jue', 'temp': '25°C', 'icon': '⛅'},
      {'day': 'Vie', 'temp': '28°C', 'icon': '☀️'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('$city: 5 Días'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Pronóstico para $city',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            // Un renglón horizontal con scroll por si hay pantallas chicas en Landscape
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: forecast.map((f) {
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                      child: Column(
                        children: [
                          Text(f['day']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text(f['icon']!, style: const TextStyle(fontSize: 24)),
                          const SizedBox(height: 8),
                          Text(f['temp']!, style: const TextStyle(color: Colors.blue)),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade50),
              child: const Text('Volver', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
    );
  }
} 