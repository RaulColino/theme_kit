import '../config/theme_config.dart';

/// Template for generating the color class
class ColorTemplate {
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
  static ${config.prefix.toUpperCase()}Theme? _theme;

  static void setTheme(${config.prefix.toUpperCase()}Theme theme) {
    _theme = theme;
  }

$getters
}
''';
  }
}
