import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:sample_mangakakalot_db/backend/BookModel.dart';
import 'package:sample_mangakakalot_db/backend/SearchBookModel.dart';
import 'package:sample_mangakakalot_db/backend/getter_selector.dart';

class MangakakalotGetter implements GenerateBookFromSearchBook {
  SearchBook searchBook;

  MangakakalotGetter(this.searchBook);

  /// todo: change function name
  Future<Book> getBook() async {
    Book book = Book.generateFromSearchBook(searchBook);

    http.Response response = await http.get(Uri.parse(book.bookLink));

    if (response.statusCode != 200) {
      print("Error Occurred in getting book");
      return Future.error(Error); //todo: better error handling
    }

    Document document = parse(response.body);

    book.summary = document.querySelector("div#noidungm").text.trim();

    book.genres = getGenres(document);

    try {
      book.rating = getRating(document);
    } on Exception catch (e) {
      // TODO
      book.rating = 0.0;
    }

    book.totalChaptersList = await getChapters(document);
    // print(book); //todo: debug only
    return book; //todo verify again from here
  }

  Future<List<Chapter>> getChapters(Document document) async {
    List<Chapter> chaptersList = [];

    var allChapters = document.querySelectorAll("div.chapter-list > div.row");

    for (var each_chapter in allChapters) {
      var doc = parse(each_chapter.innerHtml);

      Chapter chapter = Chapter();
      chapter.chapterLink =
          doc.querySelector("a[href]").attributes['href'].trim();
      chapter.name = doc.querySelector("a[href]").text.trim();
      chapter.date = doc.querySelectorAll("span")[2].text.trim();
      chapter.pages = await getPages(chapter.chapterLink);

      chaptersList.add(chapter);

      // print(chapter); //todo: debug only
    }
    return chaptersList;
  }

  Future<List<Page>> getPages(String chapterLink) async {
    http.Response response = await http.get(Uri.parse(chapterLink));

    if (response.statusCode != 200) {
      print("Error in getting pages");
      return Future.error(Error); //todo: better error handling
    }

    Document document = parse(response.body);

    var allPages =
        document.querySelectorAll("div.container-chapter-reader > img[src]");

    List<Page> pagesList = [];
    for (var each_page in allPages) {
      Page page = Page();
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
    var doc = parse(
        document.querySelectorAll("ul.manga-info-text > li")[6].innerHtml);
    return doc.querySelectorAll("a").map((e) => e.text.trim()).toList();
  }

  double getRating(Document document) {
    var ratingText = document.querySelector("em#rate_row_cmd").text.trim();
    var regexp = RegExp(r"(\d+\.?\d+)(\s+\/\s+)(\d+)", caseSensitive: true);
    var match = regexp.firstMatch(ratingText);
    double rating = double.parse(match.group(1).trim()) /
        double.parse(match.group(3).trim()) *
        10;
    return rating;
  }
}
