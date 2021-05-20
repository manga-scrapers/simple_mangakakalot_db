// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BookModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['bookLink']);
  return Book(
    bookLink: json['bookLink'] as String,
    authors: json['authors'] as String,
    thumbnail: json['thumbnail'] as String,
    bookName: json['bookName'] as String,
    currentChapter: json['currentChapter'],
    summary: json['summary'] as String,
    rating: (json['rating'] as num)?.toDouble(),
    genres: (json['genres'] as List)?.map((e) => e as String)?.toList(),
    totalChaptersList: (json['totalChaptersList'] as List)
        ?.map((e) =>
            e == null ? null : Chapter.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'bookLink': instance.bookLink,
      'authors': instance.authors,
      'thumbnail': instance.thumbnail,
      'bookName': instance.bookName,
      'currentChapter': instance.currentChapter,
      'summary': instance.summary,
      'rating': instance.rating,
      'genres': instance.genres,
      'totalChaptersList': instance.totalChaptersList,
    };

Chapter _$ChapterFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['chapterLink']);
  return Chapter(
    name: json['name'] as String,
    date: json['date'] as String,
    chapterLink: json['chapterLink'] as String,
    hasRead: json['hasRead'] as bool ?? false,
    pages: (json['pages'] as List)
        ?.map((e) => e == null
            ? null
            : PageOfChapter.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ChapterToJson(Chapter instance) => <String, dynamic>{
      'name': instance.name,
      'date': instance.date,
      'chapterLink': instance.chapterLink,
      'hasRead': instance.hasRead,
      'pages': instance.pages,
    };

PageOfChapter _$PageOfChapterFromJson(Map<String, dynamic> json) {
  return PageOfChapter(
    pageLink: json['pageLink'] as String,
    pageNumber: json['pageNumber'] as int,
  );
}

Map<String, dynamic> _$PageOfChapterToJson(PageOfChapter instance) =>
    <String, dynamic>{
      'pageLink': instance.pageLink,
      'pageNumber': instance.pageNumber,
    };
