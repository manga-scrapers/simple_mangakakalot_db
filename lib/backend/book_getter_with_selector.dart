import 'package:sample_mangakakalot_db/backend/SearchBookModel.dart';
import 'package:sample_mangakakalot_db/backend/book_getters/mangakakalot_getter.dart';
import 'package:sample_mangakakalot_db/backend/book_getters/manganelo_getter.dart';
import 'package:sample_mangakakalot_db/backend/book_model.dart';

class GenerateBookFromSearchBook {
  SearchBook searchBook;

  GenerateBookFromSearchBook(this.searchBook);

  Future<Book> getBook() async {
    String domain =
        searchBook.bookLink.split(RegExp(r"(\/+)", caseSensitive: false))[1];
    Book book;
    if (domain == "mangakakalot.com") {
      var getter = MangakakalotGetter(searchBook);
      book = await getter.getBook();
    } else if (domain == "manganelo.com") {
      var getter = ManganeloGetter(searchBook);
      book = await getter.getBook();
    }
    return book;
  }

  Future<List<PageOfChapter>> getPages(String chapterLink) async {
    String domain =
        searchBook.bookLink.split(RegExp(r"(\/+)", caseSensitive: false))[1];
    if (domain == "mangakakalot.com") {
      var getter = MangakakalotGetter(searchBook);
      return getter.getPages(chapterLink);
    } else if (domain == "manganelo.com") {
      var getter = ManganeloGetter(searchBook);
      return getter.getPages(chapterLink);
    } else {
      return Future.error(Error);
    }
  }
}
