import 'package:flutter/material.dart';
import 'detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<String> cities = ['Santiago', 'Querétaro', 'México'];
  List<String> filtered = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    filtered = cities; // Al inicio muestra todas
  }

  void filterCities(String query) {
    setState(() {
      filtered = cities
          .where((c) => c.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Ciudades'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controller,
              onChanged: filterCities,
              decoration: InputDecoration(
                hintText: 'Busca una ciudad...',
                prefixIcon: const Icon(Icons.location_city),
                suffixIcon: _controller.text.isNotEmpty 
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _controller.clear();
                          filterCities('');
                        },
                      )
                    : null,
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: filtered.isEmpty
                ? const Center(child: Text('No se encontraron ciudades'))
                : ListView.builder(
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final city = filtered[index];
                      return ListTile(
                        title: Text(city),
                        subtitle: const Text('Ver pronóstico'),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(city: city),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}