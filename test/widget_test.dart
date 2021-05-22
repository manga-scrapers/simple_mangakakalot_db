// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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

    expect(find.text('Favorite'), findsOneWidget);

    // Tap the 'search' icon and trigger a frame.
    // await tester.tap(find.byIcon(Icons.search));
    // await tester.pump();

    expect(find.text('Search term must be longer than two letters'),
        findsOneWidget);
  });
}

Future<void> loadHiveAdaptersAndBoxes() async {
  await Hive.initFlutter("hive");

  Hive.registerAdapter(BookAdapter());
  Hive.registerAdapter(ChapterAdapter());
  Hive.registerAdapter(PageOfChapterAdapter());

  await Hive.openBox<Book>(R.favorite_books);
  await Hive.openBox<Book>(R.books_cache);
  await Hive.openBox<SearchBook>(R.searchBooks_cache);
  await Hive.openBox<Chapter>(R.chapters_cache);
  await Hive.openBox<PageOfChapter>(R.pages_cache);
}
