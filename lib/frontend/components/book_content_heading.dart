import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sample_mangakakalot_db/backend/book_model.dart';
import 'package:sample_mangakakalot_db/constants.dart';
import 'package:sample_mangakakalot_db/frontend/components/last_chapter_read_button.dart';
import 'package:sample_mangakakalot_db/frontend/components/scrollable_text.dart';
import 'package:sample_mangakakalot_db/names_constant.dart' as R;

class BookContentHeading extends StatefulWidget {
  final Book _book;

  BookContentHeading(this._book);

  @override
  _BookContentHeadingState createState() => _BookContentHeadingState();
}

class _BookContentHeadingState extends State<BookContentHeading> {
  Box<Book> booksCacheBox;
  ValueListenable lastReadChapterListener;

  // Box<Chapter> chaptersCacheBox;

  @override
  void initState() {
    super.initState();

    // TODO: implement initState

    booksCacheBox = Hive.box<Book>(R.books_cache);
    // chaptersCacheBox = Hive.box<Chapter>(R.chapters_cache);

    lastReadChapterListener =
        booksCacheBox.listenable(keys: [widget._book.bookLink]);
  }

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
    precacheImage(NetworkImage(widget._book.thumbnail), context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: CachedNetworkImage(
            imageUrl: widget._book.thumbnail,
            fit: BoxFit.scaleDown,
            httpHeaders: R.headers,
            placeholder: (context, url) => Icon(Icons.image_search),
          ),
        ),
        SizedBox(width: 4.0),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HorizontalScrollableText(
                widget._book.bookName,
                style: kBookNameTextStyle,
              ),
              SizedBox(height: 2.0),
              HorizontalScrollableText(
                widget._book.authors,
                style: kAuthorsTextStyle,
              ),
              SizedBox(height: 2.0),
              HorizontalScrollableText(
                //todo: properly convert
                "Genres: ${widget._book.genres.reduce((v, e) => v + " " + e)}",
              ),
              SizedBox(height: 2.0),
              HorizontalScrollableText(
                "Rating: " + widget._book.rating.toStringAsFixed(2),
              ),
              SizedBox(height: 2.0),
              Expanded(
                child: LastChapterReadButton(
                    lastReadChapterListener, widget._book),
              ),
            ],
          ),
        )
      ],
    );
  }
}
