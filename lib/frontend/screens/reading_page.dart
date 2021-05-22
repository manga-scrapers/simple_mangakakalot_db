import 'package:flutter/material.dart';
import 'package:sample_mangakakalot_db/backend/SearchBookModel.dart';
import 'package:sample_mangakakalot_db/backend/book_getter_with_selector.dart';
import 'package:sample_mangakakalot_db/backend/book_model.dart';
import 'package:sample_mangakakalot_db/frontend/components/page_image_provider.dart';
import 'package:sample_mangakakalot_db/names_constant.dart' as R;

class ReadingPage extends StatelessWidget {
  final Chapter _chapter;
  final SearchBook searchBook;

  // final int index;

  ReadingPage(this._chapter, this.searchBook);

  Future<List<PageOfChapter>> cacheImage(BuildContext context) async {
    _chapter.pages = await GenerateBookFromSearchBook(searchBook)
        .getPages(_chapter.chapterLink);
    for (var page in _chapter.pages) {
      try {
        precacheImage(NetworkImage(page.pageLink, headers: R.headers), context);
      } on Exception {
        // print("Exception in caching: " + e.toString());
      } on Error {
        // print("Error in caching: " + e.toString());
      }
    }

    return _chapter.pages;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeData.dark().scaffoldBackgroundColor,
      appBar: AppBar(
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
            _chapter.name,
            softWrap: false,
          ),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder<List<PageOfChapter>>(
            future: cacheImage(context),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Icon(Icons.close, color: Colors.red));
              }
              if (snapshot.hasData) {
                var pages = snapshot.data;
                return ListView.builder(
                  itemCount: pages.length + 1,
                  itemBuilder: (context, index) {
                    if (index == pages.length) {
                      return Center(
                        child: Text(
                          "End of Chapter",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }
                    return PageImageProvider(pages[index]);
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                );
              }
            }),
      ),
    );
  }
}
