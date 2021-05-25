import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sample_mangakakalot_db/backend/SearchBookModel.dart';
import 'package:sample_mangakakalot_db/backend/book_model.dart';
import 'package:sample_mangakakalot_db/books_cache_handler.dart';
import 'package:sample_mangakakalot_db/frontend/screens/reading_page.dart';
import 'package:sample_mangakakalot_db/names_constant.dart' as R;

class PageViewForReading extends StatefulWidget {
  final Book book;
  final SearchBook searchBook;
  final int initialPage;

  final Function callback;

  PageViewForReading(this.book, this.searchBook, this.initialPage,
      {this.callback});

  @override
  _PageViewForReadingState createState() => _PageViewForReadingState();
}

class _PageViewForReadingState extends State<PageViewForReading> {
  Box<Chapter> chaptersBox;
  Box<Book> favBooksBox;
  Box<Book> booksCacheBox;
  int currentIndex;

  @override
  void initState() {
    super.initState();

    // TODO: implement initState
    chaptersBox = Hive.box<Chapter>(R.chapters_cache);
    favBooksBox = Hive.box<Book>(R.favorite_books);
    booksCacheBox = Hive.box<Book>(R.books_cache);
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: widget.book.totalChaptersList.length,
      controller: PageController(
        keepPage: true,
        initialPage: widget.initialPage ?? 0,
      ),
      itemBuilder: (context, index) {
        currentIndex = index;

        widget.book.totalChaptersList[index].hasRead = true;

        widget.book.lastChapterRead = widget.book.totalChaptersList[index];

        BookStoringHandler.putWithCare(
            favBooksBox, widget.book.bookLink, widget.book);

        BookStoringHandler.putWithCare(
            booksCacheBox, widget.book.bookLink, widget.book);

        Chapter chapter = widget.book.totalChaptersList[index];

        chaptersBox.put(chapter.chapterLink, chapter);

        return Scaffold(
          body: ReadingPage(chapter, widget.searchBook),
        );
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.callback(widget.book.totalChaptersList[currentIndex]);
    });

    super.dispose();
  }
}
