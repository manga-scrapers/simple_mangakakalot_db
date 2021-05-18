import 'package:flutter/material.dart';
import 'package:sample_mangakakalot_db/frontend/screens/favorites_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.red.shade50,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        ),
      ),
      home: FavoritesPage(),
    );
  }
}
