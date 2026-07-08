import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../utils/weather_utils.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Carga inicial de datos de la ciudad predeterminada sin bloquear el build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<WeatherProvider>(context, listen: false).loadWeather('Santiago de Querétaro');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Climate'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade100,
      ),
      body: Consumer<WeatherProvider>(
        builder: (context, weatherProvider, _) {
          if (weatherProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (weatherProvider.errorMessage != null) {
            return Center(child: Text('Error: ${weatherProvider.errorMessage}'));
          }

          final weatherData = weatherProvider.weather;
          if (weatherData == null) {
            return const Center(child: Text('No data available'));
          }

          // Determinar temperatura según la unidad activa
          double displayedTemp = weatherData.temperature.toDouble();
          if (weatherProvider.temperatureUnit == '°F') {
            displayedTemp = WeatherUtils.celsiusToFahrenheit(weatherData.temperature);
          }

          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${displayedTemp.toStringAsFixed(1)}${weatherProvider.temperatureUnit}',
                    style: const TextStyle(fontSize: 72, fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    weatherData.city,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Condición: ${WeatherUtils.getWeatherIcon(weatherData.condition)}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Humedad: ${weatherData.humidity}%',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () => weatherProvider.toggleTemperatureUnit(),
                    child: const Text('Cambiar unidad (°C / °F)'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () async {
                      // Al volver de buscar, si seleccionamos una ciudad, la cargamos
                      final selectedCity = await Navigator.push<String>(
                        context,
                        MaterialPageRoute(builder: (context) => const SearchScreen()),
                      );
                      if (selectedCity != null && mounted) {
                        weatherProvider.loadWeather(selectedCity);
                      }
                    },
                    icon: const Icon(Icons.search),
                    label: const Text('Buscar Ciudades'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}