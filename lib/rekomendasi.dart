import 'package:flutter/material.dart';

class RekomendasiPage extends StatelessWidget {
  final List<Map<String, String>> joggingPlaces = [
    {
      'name': 'Taman Kota',
      'image': 'https://via.placeholder.com/150', // Replace with actual image URL
      'link': 'https://goo.gl/maps/example1', // Replace with actual Google Maps link
    },
    {
      'name': 'Lapangan Olahraga',
      'image': 'https://via.placeholder.com/150', // Replace with actual image URL
      'link': 'https://goo.gl/maps/example2', // Replace with actual Google Maps link
    },
    {
      'name': 'Pantai Jogging Track',
      'image': 'https://via.placeholder.com/150', // Replace with actual image URL
      'link': 'https://goo.gl/maps/example3', // Replace with actual Google Maps link
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rekomendasi Jogging'),
      ),
      body: ListView.builder(
        itemCount: joggingPlaces.length,
        itemBuilder: (context, index) {
          final place = joggingPlaces[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  place['image']!,
                  fit: BoxFit.cover,
                  height: 150,
                  width: double.infinity,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    place['name']!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Open Google Maps link
                      launchURL(place['link']!);
                    },
                    child: const Text('Buka di Google Maps'),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          );
        },
      ),
    );
  }

  void launchURL(String url) async {
    // You may want to use the url_launcher package for this
    // To use it, add it to your pubspec.yaml dependencies
    // Example: url_launcher: ^6.0.20
  }
}
