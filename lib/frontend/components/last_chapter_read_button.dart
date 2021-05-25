import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sample_mangakakalot_db/backend/SearchBookModel.dart';
import 'package:sample_mangakakalot_db/backend/book_model.dart';
import 'package:sample_mangakakalot_db/frontend/components/scrollable_text.dart';
import 'package:sample_mangakakalot_db/frontend/screens/page_view_for_reading.dart';
import 'package:sample_mangakakalot_db/names_constant.dart' as R;

class LastChapterReadButton extends StatefulWidget {
  final ValueListenable<Box<Book>> lastReadChapterListener;
  final Book _book;

  LastChapterReadButton(this.lastReadChapterListener, this._book);

  @override
  _LastChapterReadButtonState createState() => _LastChapterReadButtonState();
}

class _LastChapterReadButtonState extends State<LastChapterReadButton> {
  Box<Chapter> chaptersBox;

  Chapter getLastChapterRead(Box<Book> value) {
    Book widgetBook = widget._book;
    if (value.containsKey(widgetBook.bookLink)) {
      if (value.get(widgetBook.bookLink).lastChapterRead != null) {
        return value.get(widgetBook.bookLink).lastChapterRead;
      }
    }
    return widgetBook.totalChaptersList.last;
  }

  int getChapterNumber() {
    Chapter lastChapter =
        getLastChapterRead(widget.lastReadChapterListener.value);

    for (int i = 0; i < widget._book.totalChaptersList.length; i++) {
      var x = widget._book.totalChaptersList[i];
      if (x.chapterLink == lastChapter.chapterLink) {
        return i;
      }
    }

    return -1; // todo : better handling
  }

  void callback(Chapter chapter) {
    setState(() {
      chaptersBox.put(chapter.chapterLink, chapter);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    chaptersBox = Hive.box(R.chapters_cache);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            textStyle:
                Theme.of(context).textTheme.button.copyWith(fontSize: 16.0)),
        onPressed: () {
          //todo

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PageViewForReading(
                widget._book,
                SearchBook.fromBook(widget._book),
                getChapterNumber(),
                callback: callback,
              ),
            ),
          );
        },
        child: Row(
          children: [
            Expanded(child: AutoSizeText(" Read")),
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
