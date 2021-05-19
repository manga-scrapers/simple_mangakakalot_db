import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_mangakakalot_db/backend/BookModel.dart';
import 'package:sample_mangakakalot_db/frontend/components/book_content_heading.dart';
import 'package:sample_mangakakalot_db/frontend/components/scrollable_text.dart';

class BookContentPage extends StatelessWidget {
  final Book _book;

  BookContentPage(this._book);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Detail"),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: BookContentHeading(_book),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  ExpansionTile(
                    title: Text("Summary"),
                    childrenPadding: EdgeInsets.all(8.0),
                    children: [
                      Text(_book.summary ?? "Summary"),
                    ],
                  ),
                  Expanded(
                    flex: 3,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      itemCount: _book.totalChaptersList.length,
                      itemBuilder: (context, index) {
                        return OutlinedButton(
                          onPressed: () {},
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: HorizontalScrollableText(
                              _book.totalChaptersList[index].name,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
