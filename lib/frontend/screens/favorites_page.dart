import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sample_mangakakalot_db/backend/SearchBookModel.dart';
import 'package:sample_mangakakalot_db/backend/book_model.dart';
import 'package:sample_mangakakalot_db/frontend/components/book_card.dart';
import 'package:sample_mangakakalot_db/frontend/components/favpage_drawer.dart';
import 'package:sample_mangakakalot_db/frontend/screens/search_screen.dart';
import 'package:sample_mangakakalot_db/names_constant.dart' as R;

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  Box<Book> favBox;

  int crossAxisCount = 3;

  @override
  void initState() {
    super.initState();

    favBox = Hive.box<Book>(R.favorite_books);
  }

  @override
  Widget build(BuildContext context) {
    // for (int i = 0; i < favBox.length; i++) {
    //   print("$i : ${favBox.keyAt(i)} : ${favBox.getAt(i).bookLink}");
    // }

    // getBook();

    if (crossAxisCount == null || crossAxisCount == 0) crossAxisCount = 3;
    // else {
    //   var width = MediaQuery.of(context).size.width;
    //   crossAxisCount = MediaQuery.of(context).size.width.round();
    // }
    return Scaffold(
      drawer: Container(
        width: MediaQuery.of(context).size.shortestSide * 1 / 2,
        child: Drawer(
          child: FavPageDrawerMenu(),
        ),
      ),
      appBar: AppBar(
        title: AutoSizeText("Favorites"),
        actions: [
          IconButton(
            onPressed: () async {
              //todo: don't await when you want to return back to fav page
              // change close method for it
              await showSearch<SearchBook>(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
            icon: Icon(FontAwesomeIcons.search),
          ),
        ],
      ),
      body: ValueListenableBuilder<Box<Book>>(
        valueListenable: favBox.listenable(),
        builder: (context, box, child) {
          if (favBox.isEmpty) {
            return Center(
              child: Text("Favorited books appear here"),
            );
          }

          return GridView.builder(
            // shrinkWrap: true,
            itemCount: box.length,
            itemBuilder: (context, index) {
              return BookCard(SearchBook.fromBook(box.getAt(index)));
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 9 / 16,
            ),
          );
        },
      ),
    );
  }
}
// return BookCard(SearchBook.fromBook(box.getAt(index)));
