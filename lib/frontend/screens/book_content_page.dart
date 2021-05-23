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
  Box<Book> favBox;

  bool isFavorite;
  Book _book;

  @override
  void initState() {
    super.initState();

    favBox = Hive.box<Book>(R.favorite_books);
    isFavorite = favBox.containsKey(widget.searchBook.bookLink);

    // using books_cache instead of fav_books
    booksCacheBox = Hive.box<Book>(R.books_cache);

    //todo: the culprit
    // _book = Book.generateFromSearchBook(widget.searchBook);
    // var x = GenerateBookFromSearchBook(widget.searchBook).getBook();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Detail"),
        actions: [
          IconButton(
            onPressed: () async {
              //todo: choose proper background color

              if (_book.lastChapterRead == null) {
                _book = await GenerateBookFromSearchBook(widget.searchBook)
                    .getBook();
              }
              if (!isFavorite) {
                BookStoringHandler.putWithCare(favBox, _book.bookLink, _book)
                    .then((value) => print("value put ${_book.bookLink}"));
              } else {
                favBox
                    .delete(_book.bookLink)
                    .then((value) => print("del value  ${_book.bookLink}"));
              }
              setState(() {
                isFavorite = favBox.containsKey(_book.bookLink);
              });
            },
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_outline,
              // color: Colors.pink,
            ),
          ),
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
                _book = snapshot.data;

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
                              searchBook: widget.searchBook,
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
