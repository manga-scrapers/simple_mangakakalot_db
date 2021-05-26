import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sample_mangakakalot_db/backend/book_model.dart';
import 'package:sample_mangakakalot_db/names_constant.dart' as R;

class PageImageProvider extends StatelessWidget {
  final PageOfChapter page;

  PageImageProvider(this.page);

  @override
  Widget build(BuildContext context) {
    try {
      return CachedNetworkImage(
        imageUrl: page.pageLink,
        httpHeaders: R.headers,
        progressIndicatorBuilder: (context, url, progress) {
          double width = MediaQuery.of(context).size.width;
          return Center(
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  width: width / 2,
                  height: width / 2,
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(
                    color: Colors.deepOrange,
                    value: progress.progress,
                  ),
                ),
                Text(
                  " ${page.pageNumber} ",
                  style: ThemeData.dark().textTheme.headline1.copyWith(
                        fontSize: 36.0,
                      ),
                ),
              ],
            ),
          );
        },
        errorWidget: (context, url, error) {
          return Icon(
            Icons.error_outline,
            color: Colors.red,
          );
        },
      );
    } catch (e) {
      // TODO
      return Icon(
        Icons.error_outline,
        color: Colors.red,
      );
    }
  }
}
