import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sample_mangakakalot_db/backend/BookModel.dart';
import 'package:sample_mangakakalot_db/file_handler.dart';
import 'package:sample_mangakakalot_db/frontend/components/book_card.dart';
import 'package:sample_mangakakalot_db/frontend/screens/book_content_page.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  Future<Book> getBook() async {
    // print(Directory.current);
    var file = await FileHandler.loadStringAsset("assets/res/file.json");

    return Book.fromJson(jsonDecode(file));
  }

  @override
  Widget build(BuildContext context) {
    getBook();
    return Scaffold(
        appBar: AppBar(
          title: Text("Favorites"),
        ),
        body: FutureBuilder(
          future: getBook(),
          builder: (BuildContext context, AsyncSnapshot<Book> snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              var book = snapshot.data;
              return Container(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookContentPage(book),
                      ),
                    );
                  },
                  child: BookCard(book.thumbnail, book.bookName,
                      book.totalChaptersList[0].name),
                ),
              );
            } else {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ));
  }
}
