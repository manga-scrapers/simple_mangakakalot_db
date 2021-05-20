import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sample_mangakakalot_db/backend/BookModel.dart';
import 'package:sample_mangakakalot_db/frontend/components/scrollable_text.dart';
import 'package:sample_mangakakalot_db/names_constant.dart' as R;

class BookContentHeading extends StatelessWidget {
  const BookContentHeading(
    this._book, {
    Key key,
  }) : super(key: key);

  final Book _book;

  @override
  Widget build(BuildContext context) {
    precacheImage(NetworkImage(_book.thumbnail), context);

    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Expanded(
        child: CachedNetworkImage(
          imageUrl: _book.thumbnail,
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
              _book.bookName,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 2.0),
            HorizontalScrollableText(
              _book.authors,
              style: TextStyle(color: Colors.grey.shade700, fontSize: 16.0),
            ),
            SizedBox(height: 2.0),
            HorizontalScrollableText(
              //todo: properly convert
              "Genres: ${_book.genres.reduce((value, element) => value + " " + element)}",
            ),
            SizedBox(height: 2.0),
            HorizontalScrollableText(
                "Rating: " + _book.rating.toStringAsFixed(2)),
            SizedBox(height: 2.0),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  OutlinedButton.icon(
                    onPressed: () {
                      //todo: change background color
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
                    label: Text(_book.currentChapter ?? "1"),
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
