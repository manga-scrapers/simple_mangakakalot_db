import 'package:auto_size_text/auto_size_text.dart';
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
    this.textAlign = TextAlign.center,
    this.overflow = TextOverflow.fade,
    this.alignment = Alignment.center,
    this.padding = const EdgeInsets.all(2.0),
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Padding(
        padding: padding,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: AutoSizeText(
            data,
            style: style,
            softWrap: false,
            textAlign: textAlign,
            overflow: overflow,
            minFontSize: 16,
          ),
        ),
      ),
    );
  }
}
