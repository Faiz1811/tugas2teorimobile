import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rekomendasi Jogging',
      home: RekomendasiPage(),
    );
  }
}

class RekomendasiPage extends StatefulWidget {
  const RekomendasiPage({super.key});

  @override
  _RekomendasiPageState createState() => _RekomendasiPageState();
}

class _RekomendasiPageState extends State<RekomendasiPage> {
  final List<Map<String, String>> joggingPlaces = [
    {
      'name': 'Maguwo',
      'image': 'assets/images/maguwo.jpg',
      'link': 'https://maps.app.goo.gl/iTnao7KwdEDyrBHE6',
    },
    {
      'name': 'Tambak Bayan',
      'image': 'assets/images/tambakboyo.jpg',
      'link': 'https://maps.app.goo.gl/FdeeLa8cHNwZTskYA',
    },
    {
      'name': 'Taman UGM',
      'image': 'assets/images/tamanugm.jpg',
      'link': 'https://maps.app.goo.gl/9YGwnmkLH4c4dqJa6',
    },
  ];

  Set<int> bookmarkedPlaces = {};

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
          final isBookmarked = bookmarkedPlaces.contains(index);

          return Card(
            margin: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () => launchURL(place['link']!),
                        child: const Text('Buka di Google Maps'),
                      ),
                      IconButton(
                        icon: Icon(
                          isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                          color: isBookmarked ? Colors.blue : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            if (isBookmarked) {
                              bookmarkedPlaces.remove(index);
                            } else {
                              bookmarkedPlaces.add(index);
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          );
        },
      ),
      backgroundColor: const Color(0xFFE6F7FF),
    );
  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
