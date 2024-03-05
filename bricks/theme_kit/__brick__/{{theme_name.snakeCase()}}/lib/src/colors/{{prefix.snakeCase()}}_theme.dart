import 'dart:ui';

class {{prefix.pascalCase()}}Theme {
  final Color? primary;
  final Color? secondary;
  final Color? success;
  final Color? warning;
  final Color? error;
  final Color? info;
  final Color? background;
  final Color? surface100;
  final Color? surface200;
  final Color? textPrimary;
  final Color? textSecondary;
  final Color? divider;
  final Color? border;

  const {{prefix.pascalCase()}}Theme({
    required this.primary,
    required this.secondary,
    required this.success,
    required this.warning,
    required this.error,
    required this.info,
    required this.background,
    required this.surface100,
    required this.surface200,
    required this.textPrimary,
    required this.textSecondary,
    required this.divider,
    required this.border,
  });
}