import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sample_mangakakalot_db/backend/book_model.dart';
import 'package:sample_mangakakalot_db/frontend/components/book_content_heading.dart';
import 'package:sample_mangakakalot_db/frontend/components/scrollable_text.dart';
import 'package:sample_mangakakalot_db/frontend/screens/reading_page.dart';
import 'package:sample_mangakakalot_db/names_constant.dart' as R;

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
    // var box = Hive.box(R.books_cache);
    // var liveBook = box.
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
        child: ValueListenableBuilder<Book>(
          valueListenable: ValueNotifier(widget._book),
          builder: (context, book, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: BookContentHeading(book),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      ExpansionTile(
                        title: Text("Summary"),
                        childrenPadding: EdgeInsets.all(8.0),
                        children: [
                          Text(book.summary ?? "Summary"),
                        ],
                      ),
                      Expanded(
                        flex: 3,
                        child: ListView.builder(
                          reverse: listViewReverse,
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          itemCount: book.totalChaptersList.length,
                          itemBuilder: (context, index) {
                            return OutlinedButton(
                              onPressed: () {
                                book.totalChaptersList[index].hasRead = true;
                                book.currentChapter =
                                    book.totalChaptersList[index];
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ReadingPage(
                                        book.totalChaptersList[index]),
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
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
