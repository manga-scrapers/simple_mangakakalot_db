import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sample_mangakakalot_db/backend/book_model.dart';
import 'package:sample_mangakakalot_db/frontend/components/scrollable_text.dart';
import 'package:sample_mangakakalot_db/names_constant.dart' as R;

class BookContentHeading extends StatefulWidget {
  const BookContentHeading(
    this._book, {
    Key key,
  }) : super(key: key);

  final Book _book;

  @override
  _BookContentHeadingState createState() => _BookContentHeadingState();
}

class _BookContentHeadingState extends State<BookContentHeading> {
  bool isFavorite = false;
  var box = Hive.box<Book>(R.favorite_books);

  @override
  Widget build(BuildContext context) {
    precacheImage(NetworkImage(widget._book.thumbnail), context);

    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 2.0),
            HorizontalScrollableText(
              widget._book.authors,
              style: TextStyle(color: Colors.grey.shade700, fontSize: 16.0),
            ),
            SizedBox(height: 2.0),
            HorizontalScrollableText(
              //todo: properly convert
              "Genres: ${widget._book.genres.reduce((value, element) => value + " " + element)}",
            ),
            SizedBox(height: 2.0),
            HorizontalScrollableText(
                "Rating: " + widget._book.rating.toStringAsFixed(2)),
            SizedBox(height: 2.0),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  OutlinedButton.icon(
                    onPressed: () {
                      //todo: change background color
                      if (!isFavorite) {
                        box.put(widget._book.bookLink, widget._book);
                      } else {
                        box.delete(widget._book.bookLink);
                      }
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                    icon: Icon(Icons.favorite_outline),
                    label: Text("Favorite"),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      textStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(width: 20.0),
                  OutlinedButton.icon(
                    onPressed: () {
                      //todo: goto page
                    },
                    icon: Text("Read "),
                    label: HorizontalScrollableText(
                        widget._book.currentChapter ?? "1"),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    ]);
  }
}
