import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:sample_mangakakalot_db/backend/SearchBookModel.dart';

class GetBooksFromSearch {
  String searchName;

  GetBooksFromSearch(this.searchName) {
    searchName =
        (searchName.trim().toLowerCase()).replaceAll(RegExp(r"(\s+)"), "_");
  }

  Future<List<SearchBook>> getSearchResults() async {
    String handler = "https://mangakakalot.com/search/story/$searchName";

    var response = await http.get(Uri.parse(handler));

    if (response.statusCode != 200) {
      print("An error occurred");
      return Future.error(Error); //todo: better error handling
    }

    var document = parse(response.body);

    List x = await _doSomeMoreWork(document);

    //todo: implement better ones
    return x;
  }

  Future<List<SearchBook>> _doSomeMoreWork(Document document) async {
    List<SearchBook> searchResults = [];

    var storyItems = document.querySelectorAll("div.story_item");

    for (var each_story in storyItems) {
      SearchBook book = new SearchBook();

      var doc = parse(each_story.innerHtml);

      book.bookLink = doc.querySelector("a[href]").attributes['href'].trim();
      book.thumbnail =
          doc.querySelector("a > img[src]").attributes['src'].trim();
      book.bookName = doc.querySelector("h3.story_name > a[href]").text.trim();
      book.authors =
          doc.querySelector("div.story_item_right > span").text.trim();
      book.latestChapter =
          doc.querySelector("em.story_chapter > a[href]").text.trim();

      //todo: debug only
      // book.printDetails();

      searchResults.add(book);
    }
    // print(searchResults); //todo: debug only
    return searchResults;
  }
}
