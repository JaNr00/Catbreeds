import 'package:flutter/material.dart';

class TextStyles {
  final bool _isTablet;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextDecoration? decoration;

  TextStyles({
    required bool isTablet,
    this.decoration,
    this.fontSize,
    this.fontWeight,
    this.color,
  }) : _isTablet = isTablet;

  TextStyle get titleHeadStyle => TextStyle(
      fontSize: _isTablet ? 28 : 26,
      fontWeight: fontWeight ?? FontWeight.bold,
      color: color ?? Colors.black87,
      decoration: decoration,
      decorationColor: color ?? Colors.black87);

  TextStyle get titleH1Style => TextStyle(
      fontSize: _isTablet ? 24 : 22,
      fontWeight: fontWeight ?? FontWeight.bold,
      color: color ?? Colors.black87,
      decoration: decoration,
      decorationColor: color ?? Colors.black87);

  TextStyle get titleH2Style => TextStyle(
      fontSize: _isTablet ? 20 : 18,
      fontWeight: fontWeight ?? FontWeight.bold,
      color: color ?? Colors.black87,
      decoration: decoration,
      decorationColor: color ?? Colors.black87);

  TextStyle get descriptionStyle => TextStyle(
      fontSize: _isTablet ? 18 : 16,
      fontWeight: fontWeight ?? FontWeight.normal,
      color: color ?? Colors.black87,
      decoration: decoration,
      decorationColor: color ?? Colors.black87);

  copywith(
          {bool? isTablet,
          double? fontSize,
          TextDecoration? decoration,
          FontWeight? fontWeight,
          Color? color}) =>
      TextStyles(
        decoration: decoration ?? this.decoration,
        isTablet: isTablet ?? _isTablet,
        fontSize: fontSize ?? this.fontSize,
        fontWeight: fontWeight ?? this.fontWeight,
        color: color ?? this.color,
      );
}
