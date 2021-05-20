import 'package:flutter/material.dart';
import 'package:sample_mangakakalot_db/backend/book_model.dart';
import 'package:sample_mangakakalot_db/frontend/components/page_image_provider.dart';
import 'package:sample_mangakakalot_db/names_constant.dart' as R;

class ReadingPage extends StatelessWidget {
  final Chapter _chapter;

  // final int index;

  ReadingPage(this._chapter);

  Future<void> cacheImage(BuildContext context) async {
    var pages = _chapter.pages;
    for (var page in pages) {
      precacheImage(NetworkImage(page.pageLink, headers: R.headers), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    /// todo: better implementation
    cacheImage(context);

    var pages = _chapter.pages;
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
        child: ListView.builder(
          itemCount: pages.length,
          itemBuilder: (context, index) {
            return PageImageProvider(pages[index]);
          },
        ),
      ),
    );
  }
}
