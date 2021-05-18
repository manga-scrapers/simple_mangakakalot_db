import 'package:sample_mangakakalot_db/backend/BookModel.dart';
import 'package:sample_mangakakalot_db/backend/SearchBookModel.dart';
import 'package:sample_mangakakalot_db/backend/book_getters/mangakakalot_getter.dart';
import 'package:sample_mangakakalot_db/backend/book_getters/manganelo_getter.dart';

class GenerateBookFromSearchBook {
  SearchBook searchBook;

  GenerateBookFromSearchBook(this.searchBook);

  Future<Book> getBook() async {
    Book book;
    var domain =
        searchBook.bookLink.split(RegExp(r"(\/+)", caseSensitive: false))[1];
    if (domain == "mangakakalot.com") {
      var getter = MangakakalotGetter(searchBook);
      book = await getter.getBook();
    } else if (domain == "manganelo.com") {
      var getter = ManganeloGetter(searchBook);
      book = await getter.getBook();
    }
    return book;
  }
}
