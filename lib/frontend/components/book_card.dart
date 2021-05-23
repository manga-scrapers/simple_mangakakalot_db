import 'package:cached_network_image/cached_network_image.dart';
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 160,
              child: CachedNetworkImage(
                imageUrl: searchBook.thumbnail,
                httpHeaders: R.headers,
                placeholder: (context, url) => Icon(Icons.image_search),
              ),
            ),
            SizedBox(height: 2.0),
            HorizontalScrollableText(
              searchBook.bookName,
              style: kBookNameTextStyle,
            ),
            SizedBox(height: 2.0),
            HorizontalScrollableText(searchBook.latestChapter),
          ],
        ),
      ),
    );
  }
}
