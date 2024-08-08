import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';

import '../helpers/config.dart';

class Labels {
  final unescape = HtmlUnescape();

  Widget label(String data, {
    double fontSize = 11,
    FontWeight fontWeight = FontWeight.normal,
    Color color = Colors.white,
    TextAlign? textAlign = TextAlign.start,
    TextOverflow? overflow = TextOverflow.visible,
    FontStyle? fontStyle,
    TextDecoration? decoration,
    TextDecorationStyle? decorationStyle,
    int? maxLines,
    double? lineHeight2,
  }) {
    return Text(unescape.convert(data),
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: lineHeight2 ?? lineHeight,
        fontStyle: fontStyle,
        decoration: decoration,
        decorationStyle: decorationStyle,
        fontFamily: 'en'
      ),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }

  Widget selectLabel(String data, {
    double fontSize = 11,
    FontWeight fontWeight = FontWeight.normal,
    Color color = Colors.white,
    TextAlign? textAlign = TextAlign.start,
    TextOverflow? overflow = TextOverflow.visible,
    FontStyle? fontStyle,
    TextDecoration? decoration,
    TextDecorationStyle? decorationStyle,
    int? maxLines,
    double lineHeight = 1.35
  }) {
    return SelectableText(unescape.convert(data),
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: lineHeight,
        fontStyle: fontStyle,
        decoration: decoration,
        decorationStyle: decorationStyle,
        fontFamily: 'en'
      ),
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }

  Widget labelRich(String title, {
    double fontSize = 11,
    FontWeight fontWeight = FontWeight.normal,
    Color color = Colors.black,
    Color? color2,
    TextAlign textAlign = TextAlign.start,
    TextOverflow? overflow = TextOverflow.visible,
    String title2 = '',
    FontWeight fontWeight2 = FontWeight.w500,
  }) {
    return RichText(
      text: TextSpan(
          style: TextStyle(fontSize: fontSize, color: color, height: lineHeight, fontFamily: 'en', fontWeight: fontWeight),
          children: [
            if(title2.isNotEmpty) TextSpan(text: title2, style: TextStyle(fontWeight: fontWeight2, color: color2)),
            TextSpan(text: title),
          ],
      ),
      textAlign: textAlign,
    );
  }

  Widget labelIcon({
    String leftTitle = '',
    String rightTitle = '',
    Widget? leftIcon,
    Widget? centerIcon,
    Widget? rightIcon,
    TextStyle? style,
    int? maxLines,
  }) {
    return RichText(
      text: TextSpan(
        style: style,
        children: [
          if(leftIcon!=null) WidgetSpan(child: leftIcon),
          if(leftTitle!='') TextSpan(text: leftTitle),
          if(centerIcon!=null) WidgetSpan(child: centerIcon),
          if(rightTitle!='')TextSpan(text: rightTitle),
          if(rightIcon!=null) WidgetSpan(child: rightIcon),
        ],
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
    );
  }

}