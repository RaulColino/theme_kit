import 'package:yaml/yaml.dart';
import 'dart:io';

/// Configuration model for theme generation
class ThemeConfig {
  final String name;
  final String prefix;
  final String? description;
  final List<String> fontFamilies;
  final List<FontWeight> fontWeights;
  final List<ColorToken> colors;
  final List<TextStyle> textStyles;

  ThemeConfig({
    required this.name,
    required this.prefix,
    this.description,
    required this.fontFamilies,
    required this.fontWeights,
    required this.colors,
    required this.textStyles,
  });

  /// Load configuration from a YAML file
  static ThemeConfig fromFile(String filePath) {
    final file = File(filePath);
    if (!file.existsSync()) {
      throw Exception('Configuration file not found: $filePath');
    }

    final yamlString = file.readAsStringSync();
    final yaml = loadYaml(yamlString) as Map;

    return ThemeConfig.fromYaml(yaml);
  }

  /// Parse configuration from YAML map
  static ThemeConfig fromYaml(Map yaml) {
    final name = yaml['name'] as String? ?? 'my_theme';
    final prefix = yaml['prefix'] as String? ?? 'mt';
    final description = yaml['description'] as String?;

    // Parse font families
    final fontFamiliesYaml = yaml['font_families'] as List? ?? [];
    final fontFamilies = fontFamiliesYaml.cast<String>();

    // If no font families specified, use default
    if (fontFamilies.isEmpty) {
      fontFamilies.add('Inter');
    }

    // Parse font weights
    final fontWeightsYaml = yaml['font_weights'] as List? ?? [];
    final fontWeights = fontWeightsYaml.map((w) {
      if (w is Map) {
        return FontWeight.fromYaml(w);
      }
      return FontWeight(name: w as String, weight: _defaultWeight(w as String));
    }).toList();

    // If no font weights specified, use defaults
    if (fontWeights.isEmpty) {
      fontWeights.addAll([
        FontWeight(name: 'regular', weight: 400),
        FontWeight(name: 'medium', weight: 500),
        FontWeight(name: 'semibold', weight: 600),
        FontWeight(name: 'bold', weight: 700),
      ]);
    }

    // Parse colors
    final colorsYaml = yaml['colors'] as Map? ?? {};
    final colors = colorsYaml.entries.map((entry) {
      return ColorToken(
        name: entry.key as String,
        description: entry.value is Map
            ? (entry.value as Map)['description'] as String?
            : null,
      );
    }).toList();

    // If no colors specified, use defaults
    if (colors.isEmpty) {
      colors.addAll([
        ColorToken(name: 'primary'),
        ColorToken(name: 'secondary'),
        ColorToken(name: 'success'),
        ColorToken(name: 'warning'),
        ColorToken(name: 'error'),
        ColorToken(name: 'info'),
        ColorToken(name: 'background'),
        ColorToken(name: 'surface100'),
        ColorToken(name: 'surface200'),
        ColorToken(name: 'textPrimary'),
        ColorToken(name: 'textSecondary'),
        ColorToken(name: 'divider'),
        ColorToken(name: 'border'),
      ]);
    }

    // Parse text styles
    final textStylesYaml = yaml['text_styles'] as List? ?? [];
    final textStyles = textStylesYaml.map((ts) {
      if (ts is Map) {
        return TextStyle.fromYaml(ts);
      }
      return TextStyle(name: ts as String);
    }).toList();

    // If no text styles specified, use defaults
    if (textStyles.isEmpty) {
      textStyles.addAll([
        TextStyle(name: 'displayXL', fontSize: 48.0),
        TextStyle(name: 'displayL', fontSize: 36.0),
        TextStyle(name: 'displayM', fontSize: 28.0),
        TextStyle(name: 'displayS', fontSize: 24.0),
        TextStyle(name: 'headingXL', fontSize: 32.0),
        TextStyle(name: 'headingL', fontSize: 28.0),
        TextStyle(name: 'headingM', fontSize: 24.0),
        TextStyle(name: 'headingS', fontSize: 20.0),
        TextStyle(name: 'bodyL', fontSize: 18.0),
        TextStyle(name: 'bodyM', fontSize: 16.0),
        TextStyle(name: 'bodyS', fontSize: 14.0),
        TextStyle(name: 'labelL', fontSize: 14.0),
        TextStyle(name: 'labelM', fontSize: 12.0),
        TextStyle(name: 'labelS', fontSize: 10.0),
      ]);
    }

    return ThemeConfig(
      name: name,
      prefix: prefix,
      description: description,
      fontFamilies: fontFamilies,
      fontWeights: fontWeights,
      colors: colors,
      textStyles: textStyles,
    );
  }

  static int _defaultWeight(String name) {
    switch (name.toLowerCase()) {
      case 'regular':
        return 400;
      case 'medium':
        return 500;
      case 'semibold':
        return 600;
      case 'bold':
        return 700;
      default:
        return 400;
    }
  }

  String get snakeCaseName => _toSnakeCase(name);
  String get pascalCaseName => _toPascalCase(name);
  String get camelCaseName => _toCamelCase(name);

  static String _toSnakeCase(String input) {
    input = input.trim();
    input = input.replaceAllMapped(
      RegExp(r'([a-z0-9])([A-Z])'),
      (match) => '${match.group(1)}_${match.group(2)}',
    );
    input = input.replaceAll(RegExp(r'\s+'), '_');
    return input.toLowerCase();
  }

  static String _toPascalCase(String input) {
    input = input.trim();
    final words = input.split(RegExp(r'[\s_-]+'));
    return words
        .map((word) => word.isEmpty
            ? ''
            : word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join('');
  }

  static String _toCamelCase(String input) {
    final pascal = _toPascalCase(input);
    return pascal.isEmpty ? '' : pascal[0].toLowerCase() + pascal.substring(1);
  }
}

class FontWeight {
  final String name;
  final int weight;

  FontWeight({required this.name, required this.weight});

  static FontWeight fromYaml(Map yaml) {
    return FontWeight(
      name: yaml['name'] as String,
      weight: yaml['weight'] as int,
    );
  }
}

class ColorToken {
  final String name;
  final String? description;

  ColorToken({required this.name, this.description});
}

class TextStyle {
  final String name;
  final double? fontSize;
  final String? fontWeight;

  TextStyle({required this.name, this.fontSize, this.fontWeight});

  static TextStyle fromYaml(Map yaml) {
    return TextStyle(
      name: yaml['name'] as String,
      fontSize: yaml['font_size'] as double?,
      fontWeight: yaml['font_weight'] as String?,
    );
  }
}
