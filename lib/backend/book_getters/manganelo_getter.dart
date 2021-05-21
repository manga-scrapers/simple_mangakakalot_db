import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:sample_mangakakalot_db/backend/SearchBookModel.dart';
import 'package:sample_mangakakalot_db/backend/book_getter_with_selector.dart';
import 'package:sample_mangakakalot_db/backend/book_model.dart';

class ManganeloGetter implements GenerateBookFromSearchBook {
  SearchBook searchBook;

  ManganeloGetter(this.searchBook);

  /// todo: change function name
  Future<Book> getBook() async {
    Book book = Book.generateFromSearchBook(searchBook);

    http.Response response = await http.get(Uri.parse(book.bookLink));

    if (response.statusCode != 200) {
      print("Error Occurred in getting book");
      return Future.error(Error); //todo: better error handling
    }

    Document document = parse(response.body);

    book.summary =
        document.querySelector("div#panel-story-info-description").text.trim();

    book.genres = getGenres(document);

    book.rating = getRating(document);

    book.totalChaptersList = await getChapters(document);
    // print(book); //todo: debug only
    return book; //todo verify again from here
  }

  Future<List<Chapter>> getChapters(Document document) async {
    List<Chapter> chaptersList = [];

    var allChapters =
        document.querySelectorAll("ul.row-content-chapter > li.a-h");

    for (var each_chapter in allChapters) {
      var doc = parse(each_chapter.innerHtml);

      Chapter chapter = Chapter();
      chapter.chapterLink =
          doc.querySelector("a[href]").attributes['href'].trim();
      chapter.name = doc.querySelector("a[href]").text.trim();
      chapter.date = doc.querySelectorAll("span")[1].text.trim();
      chapter.pages = await getPages(chapter.chapterLink);

      chaptersList.add(chapter);

      // print(chapter); //todo: debug only
    }
    return chaptersList;
  }

  Future<List<PageOfChapter>> getPages(String chapterLink) async {
    http.Response response = await http.get(Uri.parse(chapterLink));

    if (response.statusCode != 200) {
      print("Error in getting pages");
      return Future.error(Error); //todo: better error handling
    }

    Document document = parse(response.body);

    var allPages =
        document.querySelectorAll("div.container-chapter-reader > img[src]");

    List<PageOfChapter> pagesList = [];
    for (var each_page in allPages) {
      PageOfChapter page = PageOfChapter();
      page.pageLink = each_page.attributes['src'];

      var regexp =
          RegExp(r"((\d+)(\.(jpe?g|png|gif|bmp))$)", caseSensitive: false);
      page.pageNumber = int.parse(
          page.pageLink.substring(page.pageLink.indexOf(regexp)).split(".")[0]);
      pagesList.add(page);
      // print(page);//todo: debug only
    }
    return pagesList;
  }

  List<String> getGenres(Document document) {
    try {
      var doc = parse(document.querySelectorAll("td.table-value")[3].innerHtml);
      return doc.querySelectorAll("a.a-h").map((e) => e.text.trim()).toList();
    } on Exception catch (e) {
      return [];
    }
  }

  double getRating(Document document) {
    try {
      var ratingAvg = double.parse(
          document.querySelector("em[property=\"v:average\"]").text.trim());
      var ratingBest = double.parse(
          document.querySelector("em[property=\"v:best\"]").text.trim());
      var rating = ratingAvg / ratingBest * 10;
      return rating;
    } on Exception catch (e) {
      return -1;
    }
  }
}
