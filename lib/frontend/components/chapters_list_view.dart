import 'package:flutter/material.dart';
import 'package:sample_mangakakalot_db/backend/book_model.dart';
import 'package:sample_mangakakalot_db/frontend/components/scrollable_text.dart';
import 'package:sample_mangakakalot_db/frontend/screens/book_content_page.dart';
import 'package:sample_mangakakalot_db/frontend/screens/reading_page.dart';

class ChaptersListView extends StatelessWidget {
  const ChaptersListView({
    Key key,
    @required this.listViewReverse,
    @required this.book,
    @required this.widget,
  }) : super(key: key);

  final bool listViewReverse;
  final Book book;
  final BookContentPage widget;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: listViewReverse,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      itemCount: book.totalChaptersList.length,
      itemBuilder: (context, index) {
        return OutlinedButton(
          onPressed: () {
            book.totalChaptersList[index].hasRead = true;
            book.currentChapter = book.totalChaptersList[index];
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReadingPage(
                    book.totalChaptersList[index], widget.searchBook),
              ),
            );
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: HorizontalScrollableText(
              book.totalChaptersList[index].name,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        );
      },
    );
  }
}
