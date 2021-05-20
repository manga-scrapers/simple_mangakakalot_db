class SearchBook {
  String thumbnail;
  String bookName;
  String latestChapter;
  String authors;
  String bookLink;

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
