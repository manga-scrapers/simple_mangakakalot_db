import 'package:flutter/material.dart';
import 'package:sample_mangakakalot_db/backend/GetBooksFromSearch.dart';
import 'package:sample_mangakakalot_db/backend/SearchBookModel.dart';
import 'package:sample_mangakakalot_db/backend/book_getter_with_selector.dart';
import 'package:sample_mangakakalot_db/frontend/components/search_card.dart';
import 'package:sample_mangakakalot_db/frontend/screens/book_content_page.dart';

class CustomSearchDelegate extends SearchDelegate<SearchBook> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Search term must be longer than two letters.",
            ),
          )
        ],
      );
    }
    return FutureBuilder<List<SearchBook>>(
      future: GetBooksFromSearch(query).getSearchResults(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return SearchCard(
                snapshot.data[index],
                onTap: () {
                  close(context, snapshot.data[index]);
                },
              );
            },
            shrinkWrap: true,
          );
        }
        if (snapshot.hasError) {
          return Center(child: Icon(Icons.error));
        }
        return Center(
          child: CircularProgressIndicator(
            color: Colors.deepOrange,
          ),
        );
      },
    );
  }

  @override
  void close(BuildContext context, SearchBook result) {
    print("Closing/Navigating");
    GenerateBookFromSearchBook(result).getBook().then((value) {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return BookContentPage(value);
        },
      ));
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column();
  }
}
