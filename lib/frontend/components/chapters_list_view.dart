import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sample_mangakakalot_db/backend/SearchBookModel.dart';
import 'package:sample_mangakakalot_db/backend/book_model.dart';
import 'package:sample_mangakakalot_db/books_cache_handler.dart';
import 'package:sample_mangakakalot_db/constants.dart';
import 'package:sample_mangakakalot_db/frontend/components/scrollable_text.dart';
import 'package:sample_mangakakalot_db/frontend/screens/reading_page.dart';
import 'package:sample_mangakakalot_db/names_constant.dart' as R;

class ChaptersListView extends StatefulWidget {
  const ChaptersListView({
    Key key,
    @required this.listViewReverse,
    @required this.book,
    @required this.searchBook,
  }) : super(key: key);

  final bool listViewReverse;
  final Book book;
  final SearchBook searchBook;

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

  ButtonStyle getChapterButtonStyle(Chapter chapter) {
    if (chaptersBox.containsKey(chapter.chapterLink)) {
      return kChapterReadButtonStyle;
    } else {
      return kChapterUnreadButtonStyle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: widget.listViewReverse,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      itemCount: widget.book.totalChaptersList.length,
      itemBuilder: (context, index) {
        var chapter = widget.book.totalChaptersList[index];

        //todo: is this the cause??
        ButtonStyle chapterButtonStyle = getChapterButtonStyle(chapter);

        try {
          return OutlinedButton(
            // key: ValueKey(chaptersBox.get(chapter.chapterLink) ?? 0), //todo:
            style: chapterButtonStyle,
            onPressed: () async {
              widget.book.totalChaptersList[index].hasRead = true;
              widget.book.lastChapterRead =
                  widget.book.totalChaptersList[index];

              //todo: does changing order matter?
              // setState(() {
              await chaptersBox.put(chapter.chapterLink, chapter);
              // });

              //todo : i think it's optional because book_content_page uses books_cache
              BookStoringHandler.putWithCare(
                  favBooksBox, widget.book.bookLink, widget.book);

              BookStoringHandler.putWithCare(
                  booksCacheBox, widget.book.bookLink, widget.book);

              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReadingPage(
                    widget.book.totalChaptersList[index],
                    widget.searchBook,
                  ),
                ),
              );

              // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              setState(() {
                chaptersBox.put(chapter.chapterLink, chapter);
              });
              // });
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
        } on Exception catch (e) {
          print("Error in OutlinedButton: " + e.toString());
          return OutlinedButton(onPressed: () {}, child: Text("loading..."));
        }
      },
    );
  }
}
