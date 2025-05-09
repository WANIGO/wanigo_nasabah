import 'package:flutter/material.dart';
import 'screens/nasabah_home.dart';
import 'screens/setoran_page.dart'; // Import the correct file

void main() {
  runApp(const BankSampahApp());
}

class BankSampahApp extends StatelessWidget {
  const BankSampahApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bank Sampah App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Update routes to use the correct class name
      routes: {
        '/': (context) => const NasabahHomeScreen(),
        '/setoran': (context) => const SetoranPage(), // Match the class name from setoran_page.dart
      },
      initialRoute: '/',
    );
  }
}