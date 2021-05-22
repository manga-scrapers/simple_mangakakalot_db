import 'package:flutter/material.dart';

class HorizontalScrollableText extends StatelessWidget {
  final String data;
  final TextStyle style;
  final TextAlign textAlign;
  final TextOverflow overflow;

  HorizontalScrollableText(this.data,
      {this.style, this.textAlign, this.overflow});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Text(
        data,
        style: style,
        softWrap: false,
        textAlign: textAlign,
        overflow: overflow,
      ),
    );
  }
}
