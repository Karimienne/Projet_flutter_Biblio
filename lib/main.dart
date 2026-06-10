// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/catalogue_screen.dart';
import 'screens/detail_screen.dart';
import 'screens/formulaire_screen.dart';
import 'screens/apropos_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bibliothèque Lycée',
      debugShowCheckedModeBanner: false,

      // ThemeData personnalisé 
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF424242),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF424242),
          foregroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      // Routes nommées 
      initialRoute: '/',
      routes: {
        '/': (context) => const CatalogueScreen(),
        '/detail': (context) => const DetailScreen(),
        '/formulaire': (context) => const FormulaireScreen(),
        '/apropos': (context) => const AProposScreen(),
      },
    );
  }
}