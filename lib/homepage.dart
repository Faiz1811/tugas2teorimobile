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
        title: const Text('Aplikasi Joggey'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Gambar latar belakang
          Positioned.fill(
            child: Image.asset(
              '../assets/images/jogging.png', // Path gambar latar belakang
              fit: BoxFit.cover, // Mengatur agar gambar menutupi seluruh layar
            ),
          ),
          // Konten utama
          _widgetOptions.elementAt(_selectedIndex),
        ],
      ),
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
      backgroundColor: Colors
          .transparent, // Mengatur latar belakang scaffold menjadi transparan
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
            const SizedBox(height: 20),
            // Gunakan Container dengan tinggi terbatas untuk menjaga tata letak
            Container(
              height: MediaQuery.of(context).size.height * 0.4, // Menyesuaikan tinggi
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Mengurangi jarak
                children: [
                  _buildElevatedButton(context, 'Daftar Anggota', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HalamanKelompok()),
                    );
                  }),
                  const SizedBox(height: 10), // Jarak antar tombol
                  _buildElevatedButton(context, 'Aplikasi Stopwatch', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StopwatchPage()),
                    );
                  }),
                  const SizedBox(height: 10), // Jarak antar tombol
                  _buildElevatedButton(context, 'Situs Rekomendasi Jogging', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RekomendasiPage()),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk membuat ElevatedButton
  Widget _buildElevatedButton(BuildContext context, String text, VoidCallback onPressed) {
    return SizedBox(
      width: 200, // Atur lebar tombol
      height: 60, // Atur tinggi tombol
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(fontSize: 20), // Ubah ukuran font di sini
        ),
      ),
    );
  }
}

// Halaman Menu Bantuan
class HelpMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Tata Cara Penggunaan Aplikasi:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Box transparan tanpa efek blur
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8), // Warna background transparan
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.withOpacity(0.5)), // Border transparan
              ),
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                '- Daftar dan login: Kunjungi halaman pendaftaran, isi formulir dengan email dan password, lalu lakukan login menggunakan akun yang telah dibuat.\n'
                '- Fitur data kelompok: Akses menu data kelompok setelah login untuk melihat dan mengelola informasi kelompok.\n'
                '- Fitur stopwatch: Temukan dan aktifkan fitur stopwatch dari menu utama untuk mencatat waktu saat berolahraga.\n'
                '- Rekomendasi tempat jogging: Buka menu rekomendasi tempat jogging untuk melihat lokasi jogging yang disarankan berdasarkan preferensi Anda.\n',
                style: TextStyle(fontSize: 15),
              ),
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
      ),
    );
  }
}