import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info/package_info.dart';
import 'package:sample_mangakakalot_db/backend/SearchBookModel.dart';
import 'package:sample_mangakakalot_db/backend/book_model.dart';
import 'package:sample_mangakakalot_db/frontend/components/book_card.dart';
import 'package:sample_mangakakalot_db/frontend/screens/search_screen.dart';
import 'package:sample_mangakakalot_db/frontend/screens/settings_page.dart';
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(R.icon_location),
              )),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: AutoSizeText(
                  'Manga Reader',
                  minFontSize: 20.0,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Ariel",
                  ),
                ),
              ),
            ),
            FutureBuilder<PackageInfo>(
                future: PackageInfo.fromPlatform(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var packageInfo = snapshot.data;
                    return AboutListTile(
                      icon: FaIcon(FontAwesomeIcons.questionCircle),
                      child: AutoSizeText(
                        "About",
                        minFontSize: 16.0,
                      ),
                      applicationIcon: Image.asset(
                        R.icon_location,
                        width: IconTheme.of(context).size,
                        height: IconTheme.of(context).size,
                      ),
                      applicationVersion: packageInfo.version,
                      applicationName: packageInfo.appName,
                      applicationLegalese: " \xA9 by p2kr ",
                    );
                  } else {
                    return Container();
                  }
                }),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.cog),
              title: AutoSizeText(
                'Settings',
                minFontSize: 16.0,
              ),
              onTap: () async {
                // Update the state of the app.
                // ...

                await Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => SettingsPage(),
                  ),
                );
              },
            ),
          ],
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
            icon: FaIcon(FontAwesomeIcons.search),
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
