import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sample_mangakakalot_db/names_constant.dart' as R;

class BookCard extends StatelessWidget {
  final String bookThumbnail;
  final String bookName;
  final String latestChapter;

  BookCard(this.bookThumbnail, this.bookName, this.latestChapter);

  @override
  Widget build(BuildContext context) {
    precacheImage(NetworkImage(bookThumbnail), context);

    return Card(
      margin: EdgeInsets.all(2.0),
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl: bookThumbnail,
            fit: BoxFit.scaleDown,
            httpHeaders: R.headers,
            placeholder: (context, url) => Icon(Icons.image_search),
          ),
          Text(bookName),
          Text(latestChapter),
        ],
      ),
    );
  }
}
