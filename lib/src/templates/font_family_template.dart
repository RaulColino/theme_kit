import '../config/theme_config.dart';

/// Template for generating the font family class
/// 
/// Creates a class with const instances for each font family,
/// allowing type-safe font family selection in the theme.
class FontFamilyTemplate {
  /// Generates the font family class code
  /// 
  /// Returns a String containing valid Dart code for the font family class.
  static String generate(ThemeConfig config) {
    final className = '${config.prefix.toUpperCase()}FontFamily';
    final families = config.fontFamilies.map((family) {
      final fieldName = _toFieldName(family);
      return '  static const $className $fieldName = $className._("$family");';
    }).join('\n');

    return '''
/// Font families for ${config.name} theme
class $className {
  const $className._(this.name);
  final String name;

$families
}
''';
  }

  /// Converts a font family name to a valid Dart field name
  /// 
  /// Example: "Open Sans" -> "openSans"
  static String _toFieldName(String input) {
    // Convert to camelCase
    input = input.trim();
    final words = input.split(RegExp(r'[\s_-]+'));
    return words[0].toLowerCase() +
        words
            .skip(1)
            .map((word) => word.isEmpty
                ? ''
                : word[0].toUpperCase() + word.substring(1).toLowerCase())
            .join('');
  }
}
