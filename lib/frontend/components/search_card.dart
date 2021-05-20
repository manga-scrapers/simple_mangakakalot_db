import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sample_mangakakalot_db/backend/SearchBookModel.dart';
import 'package:sample_mangakakalot_db/backend/book_getter_with_selector.dart';
import 'package:sample_mangakakalot_db/frontend/screens/book_content_page.dart';

class SearchCard extends StatelessWidget {
  final SearchBook searchBook;

  SearchCard(this.searchBook);

  @override
  Widget build(BuildContext context) {
    // searchBook.printDetails(); // debug only

    return ListTile(
      leading: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: CachedNetworkImage(
          imageUrl: searchBook.thumbnail,
          fit: BoxFit.scaleDown,
        ),
      ),
      title: Text(searchBook.bookName.toString()),
      subtitle: Text(searchBook.authors.toString()),
      trailing: Text(searchBook.latestChapter.toString()),
      onTap: () {
        //todo: add functionality
        var x = GenerateBookFromSearchBook(searchBook);
        x.getBook().then(
              (value) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookContentPage(value),
                ),
              ),
            );
      },
    );
  }
}
