import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sample_mangakakalot_db/backend/SearchBookModel.dart';
import 'package:sample_mangakakalot_db/backend/book_model.dart';
import 'package:sample_mangakakalot_db/frontend/components/scrollable_text.dart';
import 'package:sample_mangakakalot_db/frontend/screens/reading_page.dart';

class LastChapterReadButton extends StatefulWidget {
  final ValueListenable<Box<Book>> lastReadChapterListener;
  final Book _book;

  LastChapterReadButton(this.lastReadChapterListener, this._book);

  @override
  _LastChapterReadButtonState createState() => _LastChapterReadButtonState();
}

class _LastChapterReadButtonState extends State<LastChapterReadButton> {
  Chapter getLastChapterRead(Box<Book> value) {
    Book widgetBook = widget._book;
    if (value.containsKey(widgetBook.bookLink)) {
      if (value.get(widgetBook.bookLink).lastChapterRead != null) {
        return value.get(widgetBook.bookLink).lastChapterRead;
      }
    }
    return widgetBook.totalChaptersList.last;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            textStyle:
                Theme.of(context).textTheme.button.copyWith(fontSize: 16.0)),
        onPressed: () async {
          //todo

          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReadingPage(
                getLastChapterRead(widget.lastReadChapterListener.value),
                SearchBook.fromBook(widget._book),
              ),
            ),
          );
        },
        child: Row(
          children: [
            Expanded(child: Text(" Read")),
            SizedBox(width: 2.0),
            ValueListenableBuilder<Box<Book>>(
              valueListenable: widget.lastReadChapterListener,
              builder: (context, value, child) {
                String chapterName = getLastChapterRead(value).name;
                return Expanded(
                  flex: 4,
                  child: HorizontalScrollableText(chapterName),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
