// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sample_mangakakalot_db/backend/SearchBookModel.dart';
import 'package:sample_mangakakalot_db/backend/book_model.dart';
import 'package:sample_mangakakalot_db/main.dart';
import 'package:sample_mangakakalot_db/names_constant.dart' as R;

void main() {
  testWidgets('Favorite Page', (WidgetTester tester) async {
    await loadHiveAdaptersAndBoxes();

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    //load boxes here
    var favBox = Hive.box<Book>(R.favorite_books);

    expect(find.text('Favorites'), findsOneWidget);

    if (favBox.isEmpty) {
      expect(find.text("Favorited books appear here"), findsOneWidget);
    } else {
      expect(find.text("Favorited books appear here"), findsNothing);
    }

    // Tap the 'search' icon and trigger a frame.
    await tester.tap(find.byIcon(FontAwesomeIcons.search));
    await tester.pumpAndSettle();

    expect(find.text('Search term must be longer than two letters'),
        findsOneWidget);

    var query = ["a", "ab", "abc"];
    for (int i = 0; i < 2; i++) {
      await tester.enterText(find.byType(TextField), query[i]);
      await tester.pumpAndSettle();
      expect(find.text('Search term must be longer than two letters'),
          findsOneWidget);
    }

    await tester.enterText(find.byType(TextField), query[2]);
    await tester.pumpAndSettle();
    expect(
        find.text('Search term must be longer than two letters'), findsNothing);
  });
}

Future<void> loadHiveAdaptersAndBoxes() async {
  await Hive.initFlutter("hive");
  print("Initialized Hive");

  Hive.registerAdapter(BookAdapter());
  Hive.registerAdapter(ChapterAdapter());
  Hive.registerAdapter(PageOfChapterAdapter());
  print("Adapters registered");

  await Hive.openBox<Book>(R.favorite_books, bytes: Uint8List(0));
  print("Opened box ${R.favorite_books}");

  await Hive.openBox<Book>(R.books_cache, bytes: Uint8List(0));
  print("Opened box ${R.books_cache}");

  await Hive.openBox<SearchBook>(R.searchBooks_cache, bytes: Uint8List(0));
  print("Opened box ${R.searchBooks_cache}");

  await Hive.openBox<Chapter>(R.chapters_cache, bytes: Uint8List(0));
  print("Opened box ${R.searchBooks_cache}");

  await Hive.openBox<PageOfChapter>(R.pages_cache, bytes: Uint8List(0));
  print("Opened box ${R.pages_cache}");
}
