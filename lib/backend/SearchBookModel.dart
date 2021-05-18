class SearchBook {
  String thumbnail = null;
  String bookName = null;
  String latestChapter = null;
  String authors = null;
  String bookLink = null;

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
