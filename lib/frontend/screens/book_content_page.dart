import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sample_mangakakalot_db/backend/SearchBookModel.dart';
import 'package:sample_mangakakalot_db/backend/book_getter_with_selector.dart';
import 'package:sample_mangakakalot_db/backend/book_model.dart';
import 'package:sample_mangakakalot_db/books_cache_handler.dart';
import 'package:sample_mangakakalot_db/frontend/components/book_content_heading.dart';
import 'package:sample_mangakakalot_db/frontend/components/chapters_list_view.dart';
import 'package:sample_mangakakalot_db/names_constant.dart' as R;

class BookContentPage extends StatefulWidget {
  final SearchBook searchBook;

  BookContentPage.fromSearchBook(this.searchBook);

  @override
  _BookContentPageState createState() => _BookContentPageState();
}

class _BookContentPageState extends State<BookContentPage> {
  bool listViewReverse = false;
  Box<Book> booksCacheBox;

  @override
  void initState() {
    super.initState();

    // using books_cache instead of fav_books
    booksCacheBox = Hive.box<Book>(R.books_cache);

    //todo: ??
    // if (!booksCacheBox.containsKey(widget.searchBook.bookLink)) {
    //   BookStoringHandler.putWithCare(booksCacheBox,widget.searchBook.bookLink,
    //       Book.generateFromSearchBook(widget.searchBook));
    // }
  }

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
        child: FutureBuilder<Book>(
            initialData: booksCacheBox.get(widget.searchBook.bookLink),
            future: GenerateBookFromSearchBook(widget.searchBook).getBook(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var book = snapshot.data;
                BookStoringHandler.putWithCare(
                    booksCacheBox, book.bookLink, book);
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
                            child: ChaptersListView(
                              listViewReverse: listViewReverse,
                              book: book,
                              widget: widget,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(color: Colors.red),
                );
              }
            }),
      ),
    );
  }
}
