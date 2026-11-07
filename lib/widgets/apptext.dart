
import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  const AppText(
      this.text, {
        super.key,
        this.style,
        this.color,
        this.fontSize,
        this.fontWeight,
        this.maxLines,
        this.overflow,
        this.textAlign,
        this.height,
        this.letterSpacing,
        this.decoration,
        this.softWrap,
      });

  final String text;
  final TextStyle? style;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final double? height;
  final double? letterSpacing;
  final TextDecoration? decoration;
  final bool? softWrap;

  @override
  Widget build(BuildContext context) {
    final themeStyle = Theme.of(context).textTheme.bodyMedium;

    return Text(
      text,
      style: themeStyle?.copyWith(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        height: height,
        letterSpacing: letterSpacing,
        decoration: decoration,
      ).merge(style),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      softWrap: softWrap,
    );
  }
}
