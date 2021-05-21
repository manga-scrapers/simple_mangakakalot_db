import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sample_mangakakalot_db/backend/SearchBookModel.dart';
import 'package:sample_mangakakalot_db/frontend/components/scrollable_text.dart';
import 'package:sample_mangakakalot_db/frontend/screens/book_content_page.dart';
import 'package:sample_mangakakalot_db/names_constant.dart' as R;

class BookCard extends StatelessWidget {
  final SearchBook searchBook;

  BookCard(this.searchBook);

  @override
  Widget build(BuildContext context) {
    precacheImage(NetworkImage(searchBook.thumbnail), context);

    return RawMaterialButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookContentPage.fromSearchBook(searchBook),
            ));
      },
      child: Card(
        margin: EdgeInsets.all(2.0),
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: searchBook.thumbnail,
              fit: BoxFit.scaleDown,
              httpHeaders: R.headers,
              placeholder: (context, url) => Icon(Icons.image_search),
            ),
            HorizontalScrollableText(searchBook.bookName),
            HorizontalScrollableText(searchBook.latestChapter),
          ],
        ),
      ),
    );
  }
}
