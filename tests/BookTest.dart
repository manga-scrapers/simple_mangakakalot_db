import 'dart:io';
import 'package:pretty_json/pretty_json.dart';
import 'package:sample_mangakakalot_db/backend/BookModel.dart';
import 'package:sample_mangakakalot_db/backend/GetBooksFromSearch.dart';
import 'package:sample_mangakakalot_db/backend/getter_selector.dart';

void main() {
  print("\n[Starting]\n");
  logic(searchIndex: 1);
}

void logic({int searchIndex = 0}) async {
  GetBooksFromSearch bookSample = GetBooksFromSearch(" tensei  shitara ");

  var searchBook = await bookSample.getSearchResults(searchIndex: searchIndex);

  // let's suppose user clicks on a search result.
  // get the particular link of SearchBook
  searchBook.printDetails();
  // then generate book for it

  var x = GenerateBookFromSearchBook(searchBook);
  Book book = await x.getBook();

  // print("In_Main: ($searchIndex) \n $book \n");
  // print("[Ending] \n");

  final filename = 'assets/res/file.json';
  var file =
      await File(filename).writeAsString(prettyJson(book.toJson(), indent: 4));

  print("[Ending] \n");
}
