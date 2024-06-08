import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../helpers/config.dart';

class Forms {

  final Config _config = Config();

  labelFormFields(String? label, { TextEditingController? controller, void Function(String)? onFieldSubmitted,
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
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor ?? _config.secondaryColor.shade100),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: TextFormField(
        autofocus: autofocus,
        enabled: enabled,
        readOnly: readOnly,
        controller: controller,
        focusNode: focusNode,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(radius),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(radius),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(radius),
          ),
          labelText: label,
          labelStyle: TextStyle(fontSize: 15, color: _config.secondaryColor.shade200),
          hintText: hintText,
          hintStyle: TextStyle(color: _config.secondaryColor.shade200, fontWeight: FontWeight.normal),
          isDense: true,
          filled: true,
          fillColor: enabled ? fillColor : _config.secondaryColor.shade50,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
        onFieldSubmitted: onFieldSubmitted,
        onTap: onTap,
        inputFormatters: inputFormatters,
        onChanged: onChanged,
      ),
    );
  }

  formField(String label, { TextEditingController? controller, void Function(String)? onFieldSubmitted,
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
  }) {
    return TextFormField(
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
        hintText: 'Be the first to comment',
        hintStyle: TextStyle(color: _config.secondaryColor.shade300),
        isDense: true,
        filled: true,
        fillColor: enabled ? fillColor : _config.secondaryColor.shade50,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      onFieldSubmitted: onFieldSubmitted,
      onTap: onTap,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
    );
  }

  text({
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
          fillColor: _config.primaryAppColor.shade300,
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

  label(String name, {bool required = false, bool error = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: _config.labelPadding),
      child: RichText(
        text: TextSpan(
            style: TextStyle(fontWeight: _config.labelWeight, fontSize: _config.labelSize, color: error ? _config.dangerColor : _config.labelColor),
            children: [
              TextSpan(text: name),
              if(required) TextSpan(text: "*", style: TextStyle(color: _config.dangerColor)),
            ]
        ),
      ),
    );
  }

}