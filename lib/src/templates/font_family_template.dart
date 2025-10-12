import '../config/theme_config.dart';

/// Template for generating the font family class
class FontFamilyTemplate {
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
