import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info/package_info.dart';
import 'package:sample_mangakakalot_db/backend/SearchBookModel.dart';
import 'package:sample_mangakakalot_db/backend/book_model.dart';
import 'package:sample_mangakakalot_db/frontend/screens/favorites_page.dart';
import 'package:sample_mangakakalot_db/names_constant.dart' as R;

void main() async {
  await Hive.initFlutter("hive");

  await loadHiveAdaptersAndBoxes();

  WidgetsFlutterBinding.ensureInitialized();

  //todo: required to set "Requires full screen" to true  for ios
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

Future<void> loadHiveAdaptersAndBoxes() async {
  Hive.registerAdapter(BookAdapter());
  Hive.registerAdapter(ChapterAdapter());
  Hive.registerAdapter(PageOfChapterAdapter());

  await Hive.openBox<Book>(R.favorite_books);
  await Hive.openBox<Book>(R.books_cache);
  await Hive.openBox<SearchBook>(R.searchBooks_cache);
  await Hive.openBox<Chapter>(R.chapters_cache);
  await Hive.openBox<PageOfChapter>(R.pages_cache);
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
