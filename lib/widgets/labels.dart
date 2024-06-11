import 'package:flutter/material.dart';

import '../helpers/config.dart';

class Labels {

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
  }) {
    return Text(data,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: lineHeight,
        fontStyle: fontStyle,
        decoration: decoration,
        decorationStyle: decorationStyle,
      ),
      textAlign: textAlign,
      overflow: overflow,
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
    );
  }

}