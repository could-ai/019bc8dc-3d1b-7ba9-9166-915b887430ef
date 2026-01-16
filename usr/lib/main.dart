import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const VCApp());
}

class VCApp extends StatelessWidget {
  const VCApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VC Portfolio Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A237E), // Indigo 900
          primary: const Color(0xFF1A237E),
          secondary: const Color(0xFF00B0FF),
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1A237E),
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
      },
    );
  }
}
