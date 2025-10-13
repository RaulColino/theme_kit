import '../config/theme_config.dart';

/// Template for generating the theme class
/// 
/// Creates the main theme configuration class that holds all color values.
/// This class is instantiated by the user to define light/dark themes.
class ThemeClassTemplate {
  // Private constructor to prevent instantiation
  ThemeClassTemplate._();

  /// Generates the theme class code
  /// 
  /// Returns a String containing valid Dart code for the theme configuration class.
  static String generate(ThemeConfig config) {
    final className = '${config.prefix.toUpperCase()}Theme';
    final parameters = config.colors.map((color) {
      return '    this.${color.name},';
    }).join('\n');

    final fields = config.colors.map((color) {
      return '  final Color? ${color.name};';
    }).join('\n');

    return '''
import 'package:flutter/material.dart';

/// Theme configuration for ${config.name}
class $className {
  $className({
$parameters
  });

$fields
}
''';
  }
}
