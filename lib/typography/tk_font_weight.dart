import 'dart:ui';

class TKFontWeight {
  const TKFontWeight._(this.value);
  final FontWeight value;

  static const regular = TKFontWeight._(FontWeight.w400);
  static const medium = TKFontWeight._(FontWeight.w500);
  static const semibold = TKFontWeight._(FontWeight.w600);
  static const bold = TKFontWeight._(FontWeight.w700);
}
