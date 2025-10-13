import '../config/theme_config.dart';

/// Template for generating the color class
/// 
/// Creates a static color accessor class that provides type-safe access
/// to theme colors through static getters.
class ColorTemplate {
  // Private constructor to prevent instantiation
  ColorTemplate._();

  /// Generates the color class code
  /// 
  /// Returns a String containing valid Dart code for the color accessor class.
  static String generate(ThemeConfig config) {
    final className = '${config.prefix.toUpperCase()}Color';
    final getters = config.colors.map((color) {
      final comment = color.description != null ? '\n  /// ${color.description}' : '';
      return '$comment\n  static Color? get ${color.name} => _theme?.${color.name};';
    }).join('\n\n');

    return '''
import 'package:flutter/material.dart';
import '${config.prefix}_theme.dart';

/// Color tokens for ${config.name} theme
class $className {
  // Private constructor to prevent instantiation
  $className._();

  static ${config.prefix.toUpperCase()}Theme? _theme;

  static void setTheme(${config.prefix.toUpperCase()}Theme theme) {
    _theme = theme;
  }

$getters
}
''';
  }
}
