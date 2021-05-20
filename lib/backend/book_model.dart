import 'package:hive/hive.dart';
import 'package:sample_mangakakalot_db/backend/SearchBookModel.dart';

part 'book_model.g.dart';

@HiveType(typeId: 0)
class Book {
  /// Do not change this. It's a primary key.
  @HiveField(0)
  String bookLink;
  @HiveField(1)
  String authors;
  @HiveField(2)
  String thumbnail;
  @HiveField(3)
  String bookName;

  //todo: finding latestChapter
  ///todo: determine datatype
  @HiveField(4)
  Chapter currentChapter;

  @HiveField(5)
  String summary;
  @HiveField(6)
  double rating = 0.0;
  @HiveField(7)
  List<String> genres = [];

  @HiveField(8)
  List<Chapter> totalChaptersList = [];

  Book({
    this.bookLink,
    this.authors,
    this.thumbnail,
    this.bookName,
    this.currentChapter,
    this.summary,
    this.rating,
    this.genres,
    this.totalChaptersList,
  });

  Book.generateFromSearchBook(SearchBook searchBook) {
    this.authors = searchBook.authors;
    this.bookLink = searchBook.bookLink;
    this.bookName = searchBook.bookName;
    this.thumbnail = searchBook.thumbnail;
  }

// @override
// String toString() {
//   return "<$bookLink , $authors , $thumbnail , $bookName , $summary , $genres , $rating , $totalChaptersList , $currentChapter>";
// }
}

@HiveType(typeId: 1)
class Chapter {
  @HiveField(0)
  String chapterLink;

  @HiveField(1)
  String name;
  @HiveField(2)
  String date;

  @HiveField(3)
  bool hasRead = false;

  @HiveField(4)
  List<PageOfChapter> pages = [];

  Chapter({
    this.name,
    this.date,
    this.chapterLink,
    this.hasRead,
    this.pages,
  });

// @override
// String toString() {
//   return "<$name , $date , $chapterLink , $has_read , $pages>";
// }

}

@HiveType(typeId: 2)
class PageOfChapter {
  @HiveField(0)
  String pageLink;
  @HiveField(1)
  int pageNumber = 0;

  PageOfChapter({
    this.pageLink,
    this.pageNumber,
  });

// @override
// String toString() {
//   return "<$pageLink , $pageNumber>";
// }
}
