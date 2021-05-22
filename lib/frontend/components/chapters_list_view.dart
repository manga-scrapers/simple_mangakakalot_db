import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sample_mangakakalot_db/backend/book_model.dart';
import 'package:sample_mangakakalot_db/books_cache_handler.dart';
import 'package:sample_mangakakalot_db/constants.dart';
import 'package:sample_mangakakalot_db/frontend/components/scrollable_text.dart';
import 'package:sample_mangakakalot_db/frontend/screens/book_content_page.dart';
import 'package:sample_mangakakalot_db/frontend/screens/reading_page.dart';
import 'package:sample_mangakakalot_db/names_constant.dart' as R;

class ChaptersListView extends StatefulWidget {
  const ChaptersListView({
    Key key,
    @required this.listViewReverse,
    @required this.book,
    @required this.widget,
  }) : super(key: key);

  final bool listViewReverse;
  final Book book;
  final BookContentPage widget;

  @override
  _ChaptersListViewState createState() => _ChaptersListViewState();
}

class _ChaptersListViewState extends State<ChaptersListView> {
  Box<Chapter> chaptersBox;
  Box<Book> favBooksBox;
  Box<Book> booksCacheBox;

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
    return ListView.builder(
      reverse: widget.listViewReverse,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      itemCount: widget.book.totalChaptersList.length,
      itemBuilder: (context, index) {
        var chapter = widget.book.totalChaptersList[index];

        ButtonStyle chapterButtonStyle = kChapterUnreadButtonStyle;
        if (chaptersBox.containsKey(chapter.chapterLink)) {
          chapterButtonStyle = kChapterReadButtonStyle;
        }

        // wrap with value listener
        return OutlinedButton(
          style: chapterButtonStyle,
          onPressed: () {
            widget.book.totalChaptersList[index].hasRead = true;
            widget.book.lastChapterRead = widget.book.totalChaptersList[index];

            //todo: does changing order matter?
            // setState(() {
            // chaptersBox.put(chapter.chapterLink, chapter);
            // });

            //todo : i think it's optional because book_content_page uses books_cache
            BookStoringHandler.putWithCare(
                favBooksBox, widget.book.bookLink, widget.book);

            BookStoringHandler.putWithCare(
                booksCacheBox, widget.book.bookLink, widget.book);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReadingPage(
                  widget.book.totalChaptersList[index],
                  widget.widget.searchBook,
                ),
              ),
            ).then(
              (value) => chaptersBox
                  .put(chapter.chapterLink, chapter)
                  .then((value) => setState(() {})),
            );
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: HorizontalScrollableText(
              widget.book.totalChaptersList[index].name,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        );
      },
    );
  }
}
