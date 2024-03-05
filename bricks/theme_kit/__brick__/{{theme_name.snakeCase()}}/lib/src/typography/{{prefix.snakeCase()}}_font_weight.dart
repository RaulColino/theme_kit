import 'dart:ui';

class {{prefix.pascalCase()}}FontWeight {
  const {{prefix.pascalCase()}}FontWeight._(this.value);
  final FontWeight value;

  static const regular = {{prefix.pascalCase()}}FontWeight._(FontWeight.w400);
  static const medium = {{prefix.pascalCase()}}FontWeight._(FontWeight.w500);
  static const semibold = {{prefix.pascalCase()}}FontWeight._(FontWeight.w600);
  static const bold = {{prefix.pascalCase()}}FontWeight._(FontWeight.w700);
}

