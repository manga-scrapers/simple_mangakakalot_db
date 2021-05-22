import 'package:hive/hive.dart';
import 'package:sample_mangakakalot_db/backend/book_model.dart';

class BookStoringHandler {
  static Future<void> putWithCare(
      Box<Book> box, dynamic key, Book value) async {
    if (box.containsKey(key)) {
      value.lastChapterRead = box.get(key).lastChapterRead;
    }
    await box.put(key, value);
  }
}
