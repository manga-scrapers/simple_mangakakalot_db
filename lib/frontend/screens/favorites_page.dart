import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:sample_mangakakalot_db/backend/SearchBookModel.dart';
import 'package:sample_mangakakalot_db/backend/book_model.dart';
import 'package:sample_mangakakalot_db/frontend/components/book_card.dart';
import 'package:sample_mangakakalot_db/frontend/screens/search_screen.dart';
import 'package:sample_mangakakalot_db/names_constant.dart' as R;

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    // getBook();
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
        actions: [
          IconButton(
            onPressed: () {
              showSearch<SearchBook>(
                context: context,
                delegate: CustomSearchDelegate(),
              ).then((searchedBook) {});
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: GridView.builder(
        itemCount: Hive.box<Book>(R.favorite_books).length,
        gridDelegate:
            SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 4),
        itemBuilder: (context, index) {
          var box = Hive.box<Book>(R.favorite_books);
          var book = box.getAt(index);
          return ValueListenableBuilder<String>(
            valueListenable: ValueNotifier(book.totalChaptersList[0].name),
            builder: (BuildContext context, value, Widget child) {
              return BookCard(book.thumbnail, book.bookName,
                  book.totalChaptersList[0].name);
            },
          );
        },
      ),
    );
  }
}
