import '../config/theme_config.dart';

/// Template for generating the theme class
class ThemeClassTemplate {
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
