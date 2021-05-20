import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_mangakakalot_db/backend/BookModel.dart';
import 'package:sample_mangakakalot_db/frontend/components/book_content_heading.dart';
import 'package:sample_mangakakalot_db/frontend/components/scrollable_text.dart';
import 'package:sample_mangakakalot_db/frontend/screens/reading_page.dart';

class BookContentPage extends StatefulWidget {
  final Book _book;

  BookContentPage(this._book);

  @override
  _BookContentPageState createState() => _BookContentPageState();
}

class _BookContentPageState extends State<BookContentPage> {
  bool listViewReverse = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Detail"),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                listViewReverse = !listViewReverse;
              });
            },
            icon: Transform(
              alignment: Alignment.center,
              transform: listViewReverse
                  ? Matrix4.rotationX(math.pi)
                  : Matrix4.identity(),
              child: Icon(Icons.sort),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: BookContentHeading(widget._book),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  ExpansionTile(
                    title: Text("Summary"),
                    childrenPadding: EdgeInsets.all(8.0),
                    children: [
                      Text(widget._book.summary ?? "Summary"),
                    ],
                  ),
                  Expanded(
                    flex: 3,
                    child: ListView.builder(
                      reverse: listViewReverse,
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      itemCount: widget._book.totalChaptersList.length,
                      itemBuilder: (context, index) {
                        return OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReadingPage(
                                    widget._book.totalChaptersList[index]),
                              ),
                            );
                          },
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: HorizontalScrollableText(
                              widget._book.totalChaptersList[index].name,
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
