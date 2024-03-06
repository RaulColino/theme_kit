import 'dart:ui';

class DvFontWeight {
  const DvFontWeight._(this.value);
  final FontWeight value;

  static const regular = DvFontWeight._(FontWeight.w400);
  static const medium = DvFontWeight._(FontWeight.w500);
  static const semibold = DvFontWeight._(FontWeight.w600);
  static const bold = DvFontWeight._(FontWeight.w700);
}

