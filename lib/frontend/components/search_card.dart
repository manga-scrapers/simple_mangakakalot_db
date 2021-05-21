import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_mangakakalot_db/backend/SearchBookModel.dart';
import 'package:sample_mangakakalot_db/constants.dart';

class SearchCard extends StatelessWidget {
  final SearchBook searchBook;
  final void Function() onTap;

  SearchCard(this.searchBook, {this.onTap});

  @override
  Widget build(BuildContext context) {
    // searchBook.printDetails(); // debug only

    return RawMaterialButton(
      onPressed: onTap,
      child: Card(
        elevation: 2.0,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: searchBook.thumbnail,
                fit: BoxFit.fitHeight,
              ),
            ),
            SizedBox(width: 5.0),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    searchBook.bookName,
                    style: kBookNameTextStyle,
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    searchBook.authors,
                    style: kAuthorsTextStyle,
                  ),
                ],
              ),
            ),
            SizedBox(width: 5.0),
            Expanded(
              child: Text(
                searchBook.latestChapter,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
