import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyle {
  static TextStyle get headline1 => TextStyle(
      fontSize: 96.sp, fontWeight: FontWeight.w300, letterSpacing: -1.5.sp);
  static TextStyle get headline2 => TextStyle(
      fontSize: 60.sp, fontWeight: FontWeight.w300, letterSpacing: -0.5.sp);
  static TextStyle get headline3 =>
      TextStyle(fontSize: 48.sp, fontWeight: FontWeight.w400);
  static TextStyle get headline4 => TextStyle(
      fontSize: 34.sp, fontWeight: FontWeight.w400, letterSpacing: 0.25.sp);
  static TextStyle get headline5 =>
      TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w400);
  static TextStyle get headline6 => TextStyle(
      fontSize: 20.sp, fontWeight: FontWeight.w500, letterSpacing: 0.15.sp);
  static TextStyle get subtitle1 => TextStyle(
      fontSize: 16.sp, fontWeight: FontWeight.w400, letterSpacing: 0.15.sp);
  static TextStyle get subtitle2 => TextStyle(
      fontSize: 14.sp, fontWeight: FontWeight.w500, letterSpacing: 0.1.sp);
  static TextStyle get bodyText1 => TextStyle(
      fontSize: 16.sp, fontWeight: FontWeight.w400, letterSpacing: 0.5.sp);
  static TextStyle get bodyText2 => TextStyle(
      fontSize: 14.sp, fontWeight: FontWeight.w400, letterSpacing: 0.25.sp);
  static TextStyle get button => TextStyle(
      fontSize: 14.sp, fontWeight: FontWeight.w500, letterSpacing: 1.25.sp);
  static TextStyle get caption => TextStyle(
      fontSize: 12.sp, fontWeight: FontWeight.w400, letterSpacing: 0.4.sp);
  static TextStyle get overline => TextStyle(
      fontSize: 10.sp, fontWeight: FontWeight.w400, letterSpacing: 1.5.sp);
}

extension TextStyleX on TextStyle {
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);
}
