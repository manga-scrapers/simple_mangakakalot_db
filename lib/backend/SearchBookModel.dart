import 'package:sample_mangakakalot_db/backend/book_model.dart';

class SearchBook {
  String thumbnail;
  String bookName;
  String latestChapter;
  String authors;
  String bookLink;

  SearchBook({
    this.thumbnail,
    this.bookName,
    this.latestChapter,
    this.authors,
    this.bookLink,
  });

  SearchBook.fromBook(Book book) {
    this.thumbnail = book.thumbnail;
    this.bookName = book.bookName;
    this.latestChapter = book.totalChaptersList[0].name;
    this.authors = book.authors;
    this.bookLink = book.bookLink;
  }

  ///debug only
  void printDetails() {
    print("\n --- ");
    print(thumbnail);
    print(bookName);
    print(latestChapter);
    print(authors);
    print(bookLink);
    print(" --- \n");
  }

  @override
  String toString() {
    return "<$thumbnail , $bookName , $latestChapter , $authors , $bookLink>";
  }
}
