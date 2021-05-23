import 'package:flutter/material.dart';

class HorizontalScrollableText extends StatelessWidget {
  final String data;
  final TextStyle style;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final Alignment alignment;
  final EdgeInsets padding;

  HorizontalScrollableText(
    this.data, {
    this.style,
    this.textAlign = TextAlign.end,
    this.overflow = TextOverflow.fade,
    this.alignment = Alignment.center,
    this.padding = const EdgeInsets.all(2.0),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Align(
        alignment: alignment,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
            data,
            style: style,
            softWrap: false,
            textAlign: textAlign,
            overflow: overflow,
          ),
        ),
      ),
    );
  }
}
