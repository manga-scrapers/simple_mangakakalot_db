import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_mangakakalot_db/backend/SearchBookModel.dart';
import 'package:sample_mangakakalot_db/constants.dart';
import 'package:sample_mangakakalot_db/frontend/components/scrollable_text.dart';
import 'package:sample_mangakakalot_db/frontend/screens/book_content_page.dart';
import 'package:sample_mangakakalot_db/names_constant.dart' as R;

class BookCard extends StatelessWidget {
  final SearchBook searchBook;

  BookCard(this.searchBook);

  @override
  Widget build(BuildContext context) {
    precacheImage(NetworkImage(searchBook.thumbnail), context);

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookContentPage.fromSearchBook(searchBook),
            ));
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 5,
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: searchBook.thumbnail,
                httpHeaders: R.headers,
                placeholder: (context, url) => Icon(Icons.image_search),
              ),
            ),
            SizedBox(width: 2.0),
            Flexible(
              child: HorizontalScrollableText(
                searchBook.bookName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(width: 2.0),
            Flexible(
              child: HorizontalScrollableText(
                searchBook.latestChapter,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
