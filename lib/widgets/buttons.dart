import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:k24/widgets/labels.dart';

import '../helpers/config.dart';

final Config config = Config();
final Labels labels = Labels();

class Buttons {

  Widget invButton({ void Function()? onTap, IconData? icon, String? text,
    Color? color,
    Widget? prefixIcons
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if(prefixIcons != null) prefixIcons,
          if(prefixIcons != null) const SizedBox(width: 6),
          if(icon != null) Icon(icon, color: color ?? config.secondaryColor.shade400, size: 24),
          if(icon != null) const SizedBox(width: 6),
          if(text != null) labels.label(text, color: config.secondaryColor.shade400, fontSize: 15),
        ],
      ),
    );
  }

  Widget button(String title,
      {
        Function()? onPressed,
        ButtonSizes buttonSize = ButtonSizes.normal,
        ButtonVariants buttonVariant = ButtonVariants.voa,
        ButtonTypes buttonType = ButtonTypes.solid,
        Color? backgroundColor,
        Color? textColor,
        Color? borderColor,
        double borderWidth = 1,
        FontWeight? fontWeight,
        Widget? prefix,
        Widget? subFix,
        IconData? iconSubFix,
        IconData? iconPrefix,
        bool showDropdown = false,
        bool showSpace = true,
      }
      ) {

    ButtonComposer buttonComposer = ButtonComposer(backgroundColor: backgroundColor, buttonVariant: buttonVariant, buttonType: buttonType, buttonSize: buttonSize, textColor: textColor, borderColor: borderColor);

    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: buttonComposer.getBackgroundColor,
        foregroundColor: buttonComposer.getTextColor,
        disabledBackgroundColor: Colors.grey.shade200,
        padding: EdgeInsets.symmetric(horizontal: buttonComposer.getPadding.left, vertical: buttonComposer.getPadding.vertical),
        minimumSize: Size.zero,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonComposer.getBorderRadius),
            side: buttonComposer.getBorderColor != null ? BorderSide(width: borderWidth, color: buttonComposer.getBorderColor!) : BorderSide.none
        ),
        textStyle: TextStyle(fontSize: buttonComposer.getFontSize, fontWeight: fontWeight ?? config.buttonFontWeight),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if(iconPrefix != null) Icon(iconPrefix, size: buttonComposer.getFontSize+6,),
          if(iconPrefix != null && showSpace) const SizedBox(width: 8,),
          if(prefix != null) prefix,
          if(prefix != null && showSpace) const SizedBox(width: 8,),
          Text(title, style: const TextStyle(fontFamily: 'en')),
          if(subFix != null && showSpace) const SizedBox(width: 8,),
          if(subFix != null) subFix,
          if(iconSubFix != null && showSpace) const SizedBox(width: 8,),
          if(iconSubFix != null) Icon(iconSubFix, size: buttonComposer.getFontSize+6,),
          if(showDropdown) Icon(Icons.arrow_drop_down, size: 22, color: Colors.black.withAlpha(900),),
        ],
      ),
    );
  }

  Widget buttonTap({
    void Function()? onTap,
    IconData? icon, double size = 20, Color? color
  }) {
    return InkWell(
      onTap: onTap,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Icon(
          icon,
          size: size,
          color: color??config.secondaryColor.shade200,
          weight: 10,
        ),
      ),
    );
  }

  Widget textButtons({
    required String title,
    required void Function()? onPressed,
    double radius = 6.0,
    double padSize = 8,
    EdgeInsetsGeometry? padding,
    bool showDropdown = false,
    IconData? prefixIcon,
    double prefixSize = 16,
    Color prefColor = Colors.black,
    Color textColor = Colors.black,
    double textSize = 13,
    FontWeight? textWeight = FontWeight.normal,
    int textLine = 1,
    Color? bgColor,
    Widget? child,
    Widget? prefixChild,
    TextAlign? textAlign = TextAlign.start,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
    Color? borderColor,
    Widget? closeButton,
    void Function()? closeButtonPress,
  }) {
    return Stack(
      children: [
        TextButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: (bgColor!=null) ? bgColor : Colors.grey.shade200,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: (borderColor ?? Colors.transparent)),
              borderRadius: BorderRadius.circular(radius),
            ),
            padding: padding ?? EdgeInsets.all(padSize),
          ),
          child: LayoutBuilder(
            builder: (context, constraint) {
              return Row(
                mainAxisAlignment: mainAxisAlignment,
                children: [
                  if(prefixIcon!=null) ...[
                    Icon(prefixIcon, size: prefixSize, color: prefColor),
                    const SizedBox(width: 6),
                  ],

                  if(prefixChild!=null) ...[
                    prefixChild,
                    const SizedBox(width: 6),
                  ],

                  Container(
                    constraints: BoxConstraints(
                      maxWidth: constraint.maxWidth - 25,
                    ),
                    child: Text(
                      title,
                      style: TextStyle(color: textColor, fontSize: textSize, fontWeight: textWeight),
                      overflow: TextOverflow.ellipsis,
                      maxLines: textLine,
                      textAlign: textAlign,
                    ),
                  ),

                  if(child!=null) ...[
                    const SizedBox(width: 6),
                    child,
                  ],

                  const SizedBox(width: 2),
                  if(showDropdown) ...[
                    const Icon(Icons.arrow_drop_down_rounded, size: 24, color: Colors.black)
                  ],
                ],
              );
            }
          ),
        ),

        /// close button //
        if(closeButton != null) Positioned(
          top: 0,
          right: 0,
          child: IconButton(
            onPressed: closeButtonPress,
            icon: closeButton,
          ),
        ),
      ],
    );
  }

  Widget dropdown(List options, {
    var initialValue,
    Function(dynamic)? onSelected,
    ButtonSizes buttonSize = ButtonSizes.normal,
    ButtonVariants buttonVariant = ButtonVariants.voa,
    ButtonTypes buttonType = ButtonTypes.solid,
    Color? backgroundColor,
    Color? textColor,
    Color? borderColor,
    double borderWidth = 1,
    FontWeight? fontWeight,
    EdgeInsetsGeometry? padding,
    String? tooltip,
    String? label,
    Widget? child,
  }) {

    ButtonComposer buttonComposer = ButtonComposer(backgroundColor: backgroundColor, buttonVariant: buttonVariant, buttonType: buttonType, buttonSize: buttonSize, textColor: textColor, borderColor: borderColor);
    String value = initialValue != null ? (initialValue is String ? initialValue : initialValue["value"]) : "";

    return PopupMenuButton(
        initialValue: initialValue,
        // Callback that sets the selected popup menu item.
        onSelected: onSelected,
        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
          for(var val in options) PopupMenuItem(
            value: val,
            child: Row(
              children: [
                if(val is Map && val["icon"] != null) Icon(val["icon"], color: val["color"] ?? config.secondaryColor,),
                if(val is Map && val["icon"] != null) const SizedBox(width: 12,),
                Text(val is String ? val : val["title"], style: val is Map && val["color"] != null ? TextStyle(color: val["color"]) : null,),
              ],
            ),
          ),
        ],
        tooltip: tooltip ?? label,
        child: Container(
          padding: padding ?? EdgeInsets.only(left: buttonComposer.getPadding.left/(child != null ? 1.5 : 1), right: buttonComposer.getPadding.right/(child != null ? 1.5 : 3), top: buttonComposer.getPadding.top, bottom: buttonComposer.getPadding.bottom),
          decoration: BoxDecoration(
              border: buttonComposer.getBorderColor != null ? Border.all(width: borderWidth, color: buttonComposer.getBorderColor!) : null,
              borderRadius: BorderRadius.circular(4),
              color: buttonComposer.getBackgroundColor
          ),
          child: child ?? Row(
            children: [
              if(label != null) Text("$label${value == "" ? "" : ": "}", style: TextStyle(fontSize: buttonComposer.getFontSize, color: value == "" ? buttonComposer.getTextColor : buttonComposer.getTextColor?.withAlpha(980)),),
              if(label == null || (initialValue != null && value != "")) Text(initialValue != null ? (initialValue is String ? initialValue : initialValue["title"]) : "Any", style: TextStyle(fontSize: buttonComposer.getFontSize, color: value != "" ? buttonComposer.getTextColor : buttonComposer.getTextColor?.withAlpha(980), fontWeight: fontWeight),),
              Icon(Icons.arrow_drop_down_rounded, color: Colors.black.withAlpha(880),)
            ],
          ),
        )
    );
  }

  Widget dropdownSearch(List options, {
    String? label,
    String? hintText,
    var initialValue,
    Function(dynamic)? onChanged,
    String titleKey="title",
    ButtonSizes buttonSize = ButtonSizes.normal,
    ButtonVariants buttonVariant = ButtonVariants.voa,
    ButtonTypes buttonType = ButtonTypes.solid,
    Color? backgroundColor,
    Color? textColor,
    Color? borderColor,
    double borderWidth = 1,
    FontWeight? fontWeight,
  }) {

    ButtonComposer buttonComposer = ButtonComposer(backgroundColor: backgroundColor, buttonVariant: buttonVariant, buttonType: buttonType, buttonSize: buttonSize, textColor: textColor, borderColor: borderColor);

    return DropdownSearch<dynamic>(
      selectedItem: initialValue,
      items: options,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          hintText: hintText ?? "Choose",
          border: buttonComposer.getBorderColor != null || buttonComposer.getBackgroundColor != null ? OutlineInputBorder(borderSide: BorderSide(color: buttonComposer.getBorderColor != null ? buttonComposer.getBorderColor! : buttonComposer.getBackgroundColor!, width: borderWidth), borderRadius: BorderRadius.circular(buttonComposer.getBorderRadius)) : InputBorder.none,
          enabledBorder: buttonComposer.getBorderColor != null || buttonComposer.getBackgroundColor != null ? OutlineInputBorder(borderSide: BorderSide(color: buttonComposer.getBorderColor != null ? buttonComposer.getBorderColor! : buttonComposer.getBackgroundColor!), borderRadius: BorderRadius.circular(buttonComposer.getBorderRadius)) : InputBorder.none,
          isDense: true,
          contentPadding: const EdgeInsets.all(12),
          hintStyle: TextStyle(fontWeight: FontWeight.normal, color: buttonComposer.getTextColor?.withAlpha(980)),
          fillColor: buttonComposer.getBackgroundColor,
          filled: true,
        ),
        baseStyle: TextStyle(fontSize: buttonComposer.getFontSize, color: buttonComposer.getTextColor, fontWeight: fontWeight),
      ),
      onChanged: onChanged,
      popupProps: PopupProps.menu(
        // showSelectedItems: true,
        showSearchBox: true,
        searchFieldProps: TextFieldProps(
            autofocus: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300, width: 1)),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300, width: 1)),
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              hintText: "Search...",

            ),
          style: const TextStyle(fontSize: 15)
        ),
        searchDelay: const Duration(milliseconds: 300),
        fit: FlexFit.loose,
        itemBuilder: (context, val, _) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text((val is Map ? val[titleKey] : val).toString(), style: const TextStyle(fontSize: 15),),
          );
        }
      ),
      filterFn: (value, filter) {
        if(filter.length > 1) return (value is Map ? value[titleKey] : value).toString().toLowerCase().contains(filter.toLowerCase());
        return (value is Map ? value[titleKey] : value).toString().toLowerCase().startsWith(filter.toLowerCase());
      },
      itemAsString: (value) => (value is Map ? value[titleKey] : value).toString(),
      dropdownBuilder: label != null ? (context, dynamic) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label+(initialValue != null ? ": ": ""), style: TextStyle(color: initialValue != null ? buttonComposer.getTextColor?.withAlpha(980) : buttonComposer.getTextColor, fontSize: buttonComposer.getFontSize),),
          if(initialValue != null) Expanded(child: Text((initialValue is Map ? initialValue[titleKey] : initialValue).toString(), overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: buttonComposer.getFontSize, color: buttonComposer.getTextColor),)),
        ],
      ) : null,
    );
  }


}

class ButtonComposer {

  ButtonSizes buttonSize;
  ButtonVariants buttonVariant;
  ButtonTypes buttonType;
  Color? backgroundColor;
  Color? textColor;
  Color? borderColor;

  ButtonComposer({
    this.buttonSize = ButtonSizes.normal,
    this.buttonVariant = ButtonVariants.voa,
    this.buttonType = ButtonTypes.solid,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
  });

  double get getBorderRadius => config.buttonRadius[buttonSize.name.toString()] ?? 6;
  double get getFontSize => config.buttonFontSizes[buttonSize.name.toString()] ?? 17;
  EdgeInsets get getPadding => config.buttonPadding[buttonSize.name.toString()] ?? const EdgeInsets.symmetric(horizontal: 18, vertical: 18);

  Color? get getTextColor => () {
    if(textColor == null) {
      textColor = (buttonType != ButtonTypes.solid ? config.buttonVariants["solid"]![buttonVariant.name.toString()] : config.buttonTextColors[buttonVariant.name.toString()]) ?? Colors.white;
      if(buttonType != ButtonTypes.solid && buttonVariant == ButtonVariants.link) textColor = config.primaryColor;
    }
    return textColor;
  }();

  Color? get getBackgroundColor => backgroundColor ?? ([ButtonTypes.outline, ButtonTypes.basic, ButtonTypes.basicOutline].contains(buttonType) ? null : (config.buttonVariants[buttonType.name.toString()]![buttonVariant.name.toString()] ?? config.primaryAppColor));

  Color? get getBorderColor => () {
    if(borderColor == null && [ButtonTypes.outline, ButtonTypes.basicOutline].contains(buttonType) && buttonVariant != ButtonVariants.link) borderColor = buttonType == ButtonTypes.basicOutline ? config.borderColor : textColor;
    return borderColor;
  }();

}

enum ButtonSizes {
  small,
  normal,
  large
}

enum ButtonVariants {
  voa,
  primary,
  secondary,
  success,
  danger,
  warning,
  info,
  link,
}

enum ButtonTypes {
  solid,
  outline,
  subtle,
  basic,
  basicOutline,
}