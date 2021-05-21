// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookAdapter extends TypeAdapter<Book> {
  @override
  final int typeId = 0;

  @override
  Book read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Book(
      bookLink: fields[0] as String,
      authors: fields[1] as String,
      thumbnail: fields[2] as String,
      bookName: fields[3] as String,
      currentChapter: fields[4] as Chapter,
      summary: fields[5] as String,
      rating: fields[6] as double,
      genres: (fields[7] as List)?.cast<String>(),
      totalChaptersList: (fields[8] as List)?.cast<Chapter>(),
    );
  }

  @override
  void write(BinaryWriter writer, Book obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.bookLink)
      ..writeByte(1)
      ..write(obj.authors)
      ..writeByte(2)
      ..write(obj.thumbnail)
      ..writeByte(3)
      ..write(obj.bookName)
      ..writeByte(4)
      ..write(obj.currentChapter)
      ..writeByte(5)
      ..write(obj.summary)
      ..writeByte(6)
      ..write(obj.rating)
      ..writeByte(7)
      ..write(obj.genres)
      ..writeByte(8)
      ..write(obj.totalChaptersList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ChapterAdapter extends TypeAdapter<Chapter> {
  @override
  final int typeId = 1;

  @override
  Chapter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Chapter(
      name: fields[1] as String,
      date: fields[2] as String,
      chapterLink: fields[0] as String,
      hasRead: fields[3] as bool,
      pages: (fields[4] as List)?.cast<PageOfChapter>(),
    );
  }

  @override
  void write(BinaryWriter writer, Chapter obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.chapterLink)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.hasRead)
      ..writeByte(4)
      ..write(obj.pages);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChapterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PageOfChapterAdapter extends TypeAdapter<PageOfChapter> {
  @override
  final int typeId = 2;

  @override
  PageOfChapter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PageOfChapter(
      pageLink: fields[0] as String,
      pageNumber: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PageOfChapter obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.pageLink)
      ..writeByte(1)
      ..write(obj.pageNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PageOfChapterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
