import 'package:flutter/material.dart';
import 'package:sample_mangakakalot_db/backend/SearchBookModel.dart';
import 'package:sample_mangakakalot_db/backend/book_model.dart';
import 'package:sample_mangakakalot_db/frontend/screens/reading_page.dart';

class PageViewForReading extends StatelessWidget {
  final List<Chapter> totalChaptersList;
  final SearchBook searchBook;
  final int initialPage;

  PageViewForReading(this.totalChaptersList, this.searchBook, this.initialPage);

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: totalChaptersList.length,
      controller: PageController(
        keepPage: true,
        initialPage: initialPage ?? 0,
      ),
      itemBuilder: (context, index) {
        return Scaffold(
          body: ReadingPage(totalChaptersList[index], searchBook),
        );
      },
    );
  }
}
