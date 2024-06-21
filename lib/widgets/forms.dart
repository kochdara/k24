import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../helpers/config.dart';

class Forms {

  final Config config = Config();

  Widget labelFormFields({
    String? labelText,
    TextEditingController? controller,
    void Function(String)? onFieldSubmitted,
    List<TextInputFormatter>? inputFormatters,
    Color? fillColor = Colors.white,
    Widget? prefixIcon,
    Widget? suffixIcon,
    void Function()? onTap,
    double radius = 4,
    TextInputType? keyboardType,
    bool enabled = true,
    void Function(String)? onChanged,
    bool readOnly = false,
    FocusNode? focusNode,
    bool autofocus = false,
    String? hintText,
    Color? borderColor,
    TextInputAction? textInputAction,
    bool obscureText = false,
    String? Function(String?)? validator,
    InputBorder? enabledBorder
  }) {
    return TextFormField(
      autofocus: autofocus,
      enabled: enabled,
      readOnly: readOnly,
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        border: enabledBorder ?? UnderlineInputBorder(
          borderSide: BorderSide(color: config.secondaryColor.shade100),
          borderRadius: BorderRadius.circular(radius),
        ),
        enabledBorder: enabledBorder ?? UnderlineInputBorder(
          borderSide: BorderSide(color: config.secondaryColor.shade100),
          borderRadius: BorderRadius.circular(radius),
        ),
        focusedBorder: enabledBorder ?? UnderlineInputBorder(
          borderSide: BorderSide(color: config.secondaryColor.shade100),
          borderRadius: BorderRadius.circular(radius),
        ),
        labelText: labelText,
        labelStyle: TextStyle(fontSize: 15, color: config.secondaryColor.shade200),
        hintText: hintText,
        hintStyle: TextStyle(color: config.secondaryColor.shade200, fontWeight: FontWeight.normal),
        isDense: true,
        filled: true,
        fillColor: enabled ? fillColor : config.secondaryColor.shade50,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      validator: validator,
      obscureText: obscureText,
      onFieldSubmitted: onFieldSubmitted,
      onTap: onTap,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      textInputAction: textInputAction,
    );
  }

  Widget formField({ TextEditingController? controller,
    List<TextInputFormatter>? inputFormatters,
    Color? fillColor = Colors.white,
    Widget? prefixIcon,
    Widget? suffixIcon,
    void Function()? onTap,
    double radius = 4,
    TextInputType? keyboardType,
    bool enabled = true,
    void Function(String)? onChanged,
    bool readOnly = false,
    FocusNode? focusNode,
    bool autofocus = false,
    String? hintText
  }) {
    return TextField(
      autofocus: autofocus,
      enabled: enabled,
      readOnly: readOnly,
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        border: UnderlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(radius),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(radius),
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: config.secondaryColor.shade200, fontWeight: FontWeight.normal),
        isDense: true,
        filled: true,
        fillColor: enabled ? fillColor : config.secondaryColor.shade50,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      onTap: onTap,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
    );
  }

  Widget text({
    Key? key,
    String? hintText,
    TextEditingController? controller,
    String? Function(String?)? validator,
    bool secure = false,
    Widget? suffixIcon,
    Widget? prefixIcon,
    Function(String?)? onSubmitted
  }) {
    return TextFormField(
      key: key,
      controller: controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
          enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
          errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          isDense: true,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.normal),
          fillColor: config.primaryAppColor.shade300,
          filled: true,
          suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        // contentPadding: const EdgeInsets.symmetric(vertical: 4)
      ),
      style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.normal),
      validator: validator,
      obscureText: secure,
      onFieldSubmitted: onSubmitted,
    );
  }

  Widget label(String name, {bool required = false, bool error = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: config.labelPadding),
      child: RichText(
        text: TextSpan(
            style: TextStyle(fontWeight: config.labelWeight, fontSize: config.labelSize, color: error ? config.dangerColor : config.labelColor),
            children: [
              TextSpan(text: name),
              if(required) TextSpan(text: "*", style: TextStyle(color: config.dangerColor)),
            ]
        ),
      ),
    );
  }

}
