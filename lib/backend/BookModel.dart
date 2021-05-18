import 'package:json_annotation/json_annotation.dart';
import 'package:sample_mangakakalot_db/backend/SearchBookModel.dart';

part 'BookModel.g.dart';

@JsonSerializable()
class Book {
  /// Do not change this. It's a primary key.
  @JsonKey(required: true)
  String bookLink;
  String authors;
  String thumbnail;
  String bookName;

  List<Chapter> totalChaptersList = [];

  ///todo: determine datatype
  var currentChapter;

  String summary;

  double rating = 0.0;

  List<String> genres = [];
  Book({
    this.bookLink,
    this.authors,
    this.thumbnail,
    this.bookName,
    this.totalChaptersList,
    this.currentChapter,
    this.summary,
    this.rating,
    this.genres,
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

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
  Map<String, dynamic> toJson() => _$BookToJson(this);
}

@JsonSerializable()
class Chapter {
  String name;
  String date;
  @JsonKey(required: true)
  String chapterLink;

  @JsonKey(defaultValue: false)
  bool hasRead = false;

  List<Page> pages = [];

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

  factory Chapter.fromJson(Map<String, dynamic> json) =>
      _$ChapterFromJson(json);
  Map<String, dynamic> toJson() => _$ChapterToJson(this);
}

@JsonSerializable()
class Page {
  String pageLink;
  int pageNumber = 0;
  Page({
    this.pageLink,
    this.pageNumber,
  });

  // @override
  // String toString() {
  //   return "<$pageLink , $pageNumber>";
  // }
  factory Page.fromJson(Map<String, dynamic> json) => _$PageFromJson(json);
  Map<String, dynamic> toJson() => _$PageToJson(this);
}
