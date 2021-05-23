import 'package:flutter/material.dart';

const kBookNameTextStyle =
    TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0);
final kAuthorsTextStyle =
    TextStyle(color: Colors.grey.shade700, fontSize: 16.0);

final ButtonStyle kChapterReadButtonStyle = OutlinedButton.styleFrom(
  backgroundColor: Colors.grey.shade400,
  // textStyle: TextStyle(
  //   fontStyle: FontStyle.italic,
  //   fontWeight: FontWeight.normal,
  // ),
);

final ButtonStyle kChapterUnreadButtonStyle = OutlinedButton.styleFrom(
  backgroundColor: Colors.transparent,
);
