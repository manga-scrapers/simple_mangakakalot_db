import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final String bookThumbnail;
  final String bookName;
  final String latestChapter;

  BookCard(this.bookThumbnail, this.bookName, this.latestChapter);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(2.0),
      child: Column(
        children: [
          Image.network(
            bookThumbnail,
            fit: BoxFit.cover,
          ),
          Text(bookName),
          Text(latestChapter),
        ],
      ),
    );
  }
}
