import 'dart:ui';

class TkFontWeight {
  const TkFontWeight._(this.value);
  final FontWeight value;

  static const regular = TkFontWeight._(FontWeight.w400);
  static const medium = TkFontWeight._(FontWeight.w500);
  static const semibold = TkFontWeight._(FontWeight.w600);
  static const bold = TkFontWeight._(FontWeight.w700);
}

