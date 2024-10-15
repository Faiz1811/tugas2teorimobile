import 'package:flutter/material.dart';
import 'loginpage.dart';
import 'halamankelompok.dart'; // Import halaman kelompok
import 'stopwatch.dart';
import 'rekomendasi.dart'; // Import the new recommendations page

class homepage extends StatefulWidget {
  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomeMainPage(),
    HelpMenuPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Application'),
        centerTitle: true,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Halaman Utama',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            label: 'Menu Bantuan',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        onTap: _onItemTapped,
      ),
    );
  }
}

// Halaman Utama
class HomeMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              'https://via.placeholder.com/150', // Ganti dengan URL gambar yang diinginkan
              height: 150,
              width: 150,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigasi ke HalamanKelompok saat tombol ditekan
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HalamanKelompok()),
                );
              },
              child: const Text('Daftar Anggota'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StopwatchPage()),
                );
              },
              child: const Text('Aplikasi Stopwatch'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigasi ke RekomendasiPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RekomendasiPage()),
                );
              },
              child: const Text('Situs Rekomendasi Jogging'),
            ),
          ],
        ),
      ),
    );
  }
}

// Halaman Menu Bantuan
class HelpMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Tata Cara Penggunaan Aplikasi:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            '- Daftar menggunakan email dan password\n'
            '- Login menggunakan akun yang sudah terdaftar\n'
            '- Navigasi menggunakan menu di bawah',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
