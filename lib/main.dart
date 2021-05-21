import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sample_mangakakalot_db/backend/book_model.dart';
import 'package:sample_mangakakalot_db/frontend/screens/favorites_page.dart';
import 'package:sample_mangakakalot_db/names_constant.dart' as R;

void main() async {
  await Hive.initFlutter("hive");

  await loadHiveAdaptersAndBoxes();

  runApp(MyApp());
}

Future<void> loadHiveAdaptersAndBoxes() async {
  Hive.registerAdapter(BookAdapter());
  Hive.registerAdapter(ChapterAdapter());
  Hive.registerAdapter(PageOfChapterAdapter());

  await Hive.openBox<Book>(R.favorite_books);
  await Hive.openBox<Book>(R.books_cache);
}

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
