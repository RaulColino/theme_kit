import '../config/theme_config.dart';

/// Template for generating the font weight class
/// 
/// Creates a class with const instances for each font weight,
/// wrapping Flutter's FontWeight values for type safety.
class FontWeightTemplate {
  // Private constructor to prevent instantiation
  FontWeightTemplate._();

  /// Generates the font weight class code
  /// 
  /// Returns a String containing valid Dart code for the font weight class.
  static String generate(ThemeConfig config) {
    final className = '${config.prefix.toUpperCase()}FontWeight';
    final weights = config.fontWeights.map((weight) {
      return '  static const ${weight.name} = $className._(FontWeight.w${weight.weight});';
    }).join('\n');

    return '''
import 'dart:ui';

/// Font weights for ${config.name} theme
class $className {
  const $className._(this.value);
  final FontWeight value;

$weights
}
''';
  }
}
